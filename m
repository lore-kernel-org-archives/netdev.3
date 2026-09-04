Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A68451474A
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788549035; cv=none; b=a1xFr5h2f4BNqjpB+vAp6uyztgoW41hQaP7QB0ZxXnfA2OHa4CGQEmUgBPnfH9IAKHmJfZzdfMmTGnylPEKSuk+pxzUSDm6OGZeWpT1WJDzkir67lPPZqJqnbK4kHcZL1YfQ3xvd+odgTw760J3TmTU3KYPSLjIxGcG7wwwJM7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788549035; c=relaxed/simple;
	bh=Bm2stx0ck/BZAqE0yN36go0o9sNHpWQ5jGE3N5q5gLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XmUbs/EimzZt45Qhqt1wsmKvIQ8KUQctGA6+Szvi0SE9W8edGa39IMTwtlA5S/TmhHg+vmsCVNNPjZF375v63hIk8z87KJ49QDfQU9FqRJ9hLsU5asZ53KkR+N95wt7rj10GNsop1O1wt4BYfqPEB6wnvxN4xfNBXuh8Dx/GVGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7f5Jzgb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7f5Jzgb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614CF1F00A3E;
	Fri,  4 Sep 2026 19:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788549028;
	bh=XlRVNy9jehvZQokTjRNw4c/+BIInOjdRWqYeHzxoxjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W7f5Jzgb0wnUYzsrivUQIROeNWC3GzEhOJa64O16AyS7zd4boUqUXZpwTTrkd3C+o
	 uAiSorcAG4LTcyb7AlGvlgVhBiKjhXymyjvK1oPmzH6gVym85AcI69FAjyb3V8u7/U
	 2o2+sqZlsUu7K5N7fsGTM9UyEf18SxQefto0Z51u/P0nfTEZ8IAndhkl/4T+rspVZG
	 5y5VFq9ihk1xy8wrp6fdvrFAa0BrM3EYS+QOb53rWyX9T93c75pl1BOVPH9FKoRJ6Q
	 DQBgzc5s04746f1zOwc56ChGUI3rGWp2iL43oVsES1G1FbITIQhoRN+Xs9R45bkHKf
	 YQBW0t1ZYbnMw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	ivecera@redhat.com,
	jiri@resnulli.us,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/4] netlink: specs: dpll: drop the pin-set attributes nothing implements
Date: Fri,  4 Sep 2026 12:10:21 -0700
Message-ID: <20260904191023.3869690-3-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904191023.3869690-1-kuba@kernel.org>
References: <20260904191023.3869690-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pin-set advertises top level direction, prio and state, so the
generated policy accepts them and the generated user space API grows
setters for them. dpll_pin_set_from_nlattr() has cases only for
FREQUENCY, PHASE_ADJUST, PARENT_DEVICE, PARENT_PIN, ESYNC_FREQUENCY and
REFERENCE_SYNC - the request succeeds, does nothing and produces no
extack. The three values are only actionable inside the parent-device
nest, where dpll_pin_parent_device_set() handles them next to
DPLL_A_PIN_PARENT_ID, which is what makes them meaningful: a pin can be
registered with more than one device.

Never implemented - "git log -S 'case DPLL_A_PIN_PRIO'" on
dpll_netlink.c comes up empty - the spec has advertised them since
commit 3badff3a25d8 ("dpll: spec: Add Netlink spec in YAML").

Note that this does change what the kernel accepts: sending one of the
three now fails validation instead of being ignored.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/dpll.yaml | 3 ---
 drivers/dpll/dpll_nl.c                | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index 64a45088c027..93e546ba1f56 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -760,9 +760,6 @@ doc: DPLL subsystem.
           attributes:
             - id
             - frequency
-            - direction
-            - prio
-            - state
             - parent-device
             - parent-pin
             - phase-adjust
diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
index b1ba490e72b0..3bdabbf2b931 100644
--- a/drivers/dpll/dpll_nl.c
+++ b/drivers/dpll/dpll_nl.c
@@ -78,9 +78,6 @@ static const struct nla_policy dpll_pin_get_dump_nl_policy[DPLL_A_PIN_ID + 1] =
 static const struct nla_policy dpll_pin_set_nl_policy[DPLL_A_PIN_REFERENCE_SYNC + 1] = {
 	[DPLL_A_PIN_ID] = { .type = NLA_U32, },
 	[DPLL_A_PIN_FREQUENCY] = { .type = NLA_U64, },
-	[DPLL_A_PIN_DIRECTION] = NLA_POLICY_RANGE(NLA_U32, 1, 2),
-	[DPLL_A_PIN_PRIO] = { .type = NLA_U32, },
-	[DPLL_A_PIN_STATE] = NLA_POLICY_RANGE(NLA_U32, 1, 3),
 	[DPLL_A_PIN_PARENT_DEVICE] = NLA_POLICY_NESTED(dpll_pin_parent_device_nl_policy),
 	[DPLL_A_PIN_PARENT_PIN] = NLA_POLICY_NESTED(dpll_pin_parent_pin_nl_policy),
 	[DPLL_A_PIN_PHASE_ADJUST] = { .type = NLA_S32, },
-- 
2.55.0

