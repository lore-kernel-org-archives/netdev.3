Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D855F4CDA23;
	Fri, 11 Sep 2026 21:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162982; cv=none; b=nOmCW6MVFACWOs0M16trY+qEKJT3gPYgRbBXLEl76up33IfdVMkqbnXjdHzkcXrIe2bzUwcEwqGXm3tMOLhuVZiB3F4hIYFbzvvjFUKFe4+WSS8ExOlEKkClTvut7qlYTCAIRYARhCCauq4yuOOj8FZczPpAX4T2FaRnFM0J7dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162982; c=relaxed/simple;
	bh=DAwD5zgag4Mld19zoZJuo56IFt6idR2zpNpsKA+KK6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rV0e95iMTUxThfWJRvTSkTl4DPIK9ZCef/FMfeLX03DOJ06HGFhJQDJXjlWXzr89zlNOKIjjc6tHos8LCvp+N/sJ/RpTKX7JeZVQFH8WXxtgoGUUnoHkXcbw9HQHj3otO48bENKM2Bq6Z9Xwy4u+psWT8lMGf1I+ks0WCA3o/j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=FhU0N8Rg; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="FhU0N8Rg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1789162978;
	bh=DAwD5zgag4Mld19zoZJuo56IFt6idR2zpNpsKA+KK6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FhU0N8RgvE0B2sE31gIRazQT7v+ATzU/chniAFnqM2ret46QcPjgFB9h/tZKoZSrr
	 cdctc1WBOtKGbLF2AcC8kcGAASSHboW/EHg+RsLME/5XELmxFbkoaolxH+o9M8J93o
	 O8nBU/i1LE7mHlw9ZZKKVCuY9aLvclIZausyetS1yhsoVXa3ZXvSVvpsgrl+4I7UAa
	 AqrllxRxqy1ue81YOj4mVZiI7U7FvQjkldwM33saO07+gY2xkJXcSeddwVxq7gMXHF
	 xoopvzAPEKc9uIzMCHCcFOXQ8aArzRJvhhJayzbsjajPBG4jaa1y7FGdUxjFVChj5X
	 dmXQ+kLLzPdeg==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 35A8C60103;
	Fri, 11 Sep 2026 21:42:42 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 4BA60202556; Fri, 11 Sep 2026 21:42:21 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Danielle Ratson <danieller@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	=?UTF-8?q?Jonas=20K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH net-next 09/10] netlink: specs: tc: fix typo in cls-flags
Date: Fri, 11 Sep 2026 21:41:35 +0000
Message-ID: <20260911214148.1184806-10-ast@fiberby.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911214148.1184806-1-ast@fiberby.net>
References: <20260911214148.1184806-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix a typo in the naming of a cls-flags constant.

The correct name for TCA_CLS_FLAGS_NOT_IN_HW is "not-in-hw",
not "not-in-nw".

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
CC: Jamal Hadi Salim <jhs@mojatatu.com>
CC: "Jonas Köppeler" <j.koeppeler@tu-berlin.de>
CC: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
CC: "Toke Høiland-Jørgensen" <toke@redhat.com>
---
 Documentation/netlink/specs/tc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index 2e663333a279..b6ccc645b0e3 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -42,7 +42,7 @@ definitions:
       - skip-hw
       - skip-sw
       - in-hw
-      - not-in-nw
+      - not-in-hw
       - verbose
   -
     name: flower-key-ctrl-flags
-- 
2.55.0

