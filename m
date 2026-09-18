Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B11E52120D
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 18:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789757619; cv=none; b=Sj2h60wzPeE5oh8jRRApaJ0oLwVkcNjT4mg6k3vHYD9iF701xDl9we+RcLbq8BqEp2nlKGUYhAa2QiKpGRsmzaJJ25dhiJQS4qC6WWmy05QAzVq7cJeM2ihG1Nl6nHw2sFr96NdbRkc0sh5wRmAHBp+h8omDzmmZUGB7/v6AWzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789757619; c=relaxed/simple;
	bh=PVBwg4ebsMvQc6gnb0PZgfl1VmbDursjRT3R/WSXi0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nnbqWW03Y6mTW118xwCIEZdKedUVJkp4OKvIv1vCke6RdeHkNz8fhHzrvLvI4Ksix6BFvmaPwmCgVCPknXv10F4nIgPEP80C68NcO47Lj+Zso/nEGKSqZx4HJFa7qXJtNJIodY0LG0Q4CmKAAJ2oz/R9LfwzeT0iesNNtA//x3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0mip4yf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0mip4yf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CE71F00898;
	Fri, 18 Sep 2026 18:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789757611;
	bh=dXiWj+cq7kaiGr8rb/sJjFfze+iQP0LBn8c/P+X7p+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D0mip4yfOsop3P8ipjwBSCV+9BQlv7oXxz0YdkqfqF83TH9cs1xmO+ydQJYCE9B35
	 oRX3pZGoJfM1gf9bQMBCX+gAB7Gc1G/053h4SMTCxM2pEfyOMzgPj6bnAArv+SgK/R
	 MsushdLPCvFc+m/NAKaFUcT1aZlz81JYSQUT70EjLatAAHUbQJixJSAc1k97e5cKtw
	 C/lIRQ+lVr6o6DBLl7j57e3bpSG1NztN+7gOy4FxC1AzBPge4ok2Qv2rhlI/n675eU
	 OANMvbBJmxPlXIMGROSpVvwfEEFm9YoImVnxbRusu/DtJnFJJs5zqt3yEmsLHcpKvi
	 ViB8ISC7ZGKPw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	olteanv@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	vivien.didelot@gmail.com
Subject: [PATCH net-next 2/2] net: dsa: mv88e6xxx: check the port when deleting a policy rule
Date: Fri, 18 Sep 2026 11:53:26 -0700
Message-ID: <20260918185326.3940857-3-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918185326.3940857-1-kuba@kernel.org>
References: <20260918185326.3940857-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ETHTOOL_SRXCLSRLDEL removes the policy the location names out of the
switch-wide IDR without checking which port owns it, then hands it to
mv88e6xxx_policy_apply() along with the port the request arrived on.
Deleting another port's rule therefore purges an ATU entry on and clears
the policy register of the requesting port, while the owning port keeps
its hardware policy - and, with the software object freed, no longer has
a location that can be used to remove it.

Initially I thought that we're just able to delete a rule from one port
using another port as a handle. But if the reading of the code outlined
above is correct, this is just borken, not a "feature" someone could
depend on.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: olteanv@gmail.com
CC: f.fainelli@gmail.com
CC: vivien.didelot@gmail.com
---
 drivers/net/dsa/mv88e6xxx/chip.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index daef7c78b860..7b34cae9c542 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -2503,8 +2503,9 @@ static int mv88e6xxx_set_rxnfc(struct dsa_switch *ds, int port,
 		break;
 	case ETHTOOL_SRXCLSRLDEL:
 		err = -ENOENT;
-		policy = idr_remove(&chip->policies, fs->location);
-		if (policy) {
+		policy = idr_find(&chip->policies, fs->location);
+		if (policy && policy->port == port) {
+			idr_remove(&chip->policies, fs->location);
 			policy->action = MV88E6XXX_POLICY_ACTION_NORMAL;
 			err = mv88e6xxx_policy_apply(chip, port, policy);
 			devm_kfree(chip->dev, policy);
-- 
2.55.0

