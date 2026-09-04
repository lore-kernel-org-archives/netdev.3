Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C794EA380
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 19:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788549034; cv=none; b=Xn0RquD7vLR4CObY50KSWVh0ptdLDt+HuCS5KY4DJIv3vUymY4XqpjQAsSEboW1x0GvFCdW7eu1IQFjQL5mXzZPxf5cfhcPWgSi/K/MXUKN/CuV3qz1Bu+4FYG+0Au/MT7hKYnjkViWX07PxBt+G2c1RBuq44AIuRMMr4N5Wzy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788549034; c=relaxed/simple;
	bh=1kiyKjWMOKHwUiDyCQ0peG+zuatDNI7KoHDkGDQst+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecatncCXDjedQ9ELYxE/hM1BGUicGXsSh4w39no4PGO/QhkY5dCpwFMdKqsUUj8w6+MTAGYel6TxKt1l4QKv+RlOPr52Fj3W1Db96xr+lp2dq6Yp0/JUklf2yT7QrTOOdm4HpEooOBpZ5LD3aRAyvdvmZRqB6KPTJhQxFKbh8mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zgxdg9eR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zgxdg9eR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65851F00AC4;
	Fri,  4 Sep 2026 19:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788549029;
	bh=5B5r1D993WtsojtgP8+2pJ1HbCvdAeY+GvTsy57zuh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zgxdg9eRZ7AqQFVkefuFxxzFFmm2ekk4nIQ49QaZwtd+bH6rFTrr3fjjodKA4o2is
	 SQ1cWI8eOL5WwNPdFwr12Mg2hk0AyC7c2cg7SFrsZISUR/95JsF5AAL8EHuH9ZMzvA
	 AG1LnIDy3vuCCQavhWJb+u7Al8cZzg/TR3wagt10gIpLzx5rmf6gPix/K1F+ZhbH8v
	 ztm/1lvj7AvDMLhCpwpTR7yi1KxWwlpwi7d2Y7hlV1spX2j2nuVQcXRv1BokZyqMgZ
	 knsnDDZb4NuHf2yogyqVvs7bSu0X8a8Cnx0ZQgPPB8ngY9JsrvwVfbo92zNC6iUtR9
	 48nv+F04U0PiA==
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
Subject: [PATCH net-next 3/4] netlink: specs: dpll: pin-get has no dump filter
Date: Fri,  4 Sep 2026 12:10:22 -0700
Message-ID: <20260904191023.3869690-4-kuba@kernel.org>
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

The op doc promises "dump request with target dpll - list all the pins
registered with a given dpll device" and "do request with target dpll
and target pin". Neither exists. pin-get uses attribute-set: pin, so
the id in both requests is DPLL_A_PIN_ID, not a device id; there is no
reachable "target dpll" attribute at all (DPLL_A_PIN_PARENT_ID is in
neither list). dpll_nl_pin_get_dumpit() does not look at the request,
it walks dpll_pin_xa from ctx->idx and emits every registered,
available pin, and there is no dump start callback to consume an id
either.

So the generated dpll_pin_get_dump() sends an id, gets the full list
back and reports no error. Drop the id from the dump request and the
two targeting claims from the doc.

Present since commit 3badff3a25d8 ("dpll: spec: Add Netlink spec in
YAML").
Same caveat as for pin-set: sending DPLL_A_PIN_ID in a pin-get dump now
fails validation instead of being ignored.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/dpll.yaml | 11 +++--------
 drivers/dpll/dpll_nl.c                | 17 +++++------------
 2 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index 93e546ba1f56..e2ca4df5699a 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -701,11 +701,9 @@ doc: DPLL subsystem.
       doc: |
         Get list of pins and its attributes.
 
-        - dump request without any attributes given - list all the pins in the
-          system
-        - dump request with target dpll - list all the pins registered with
-          a given dpll device
-        - do request with target dpll and target pin - single pin attributes
+        - dump request - list all the registered, available pins in the
+          system, the request takes no attributes
+        - do request with target pin - single pin attributes
       attribute-set: pin
       flags: [admin-perm]
 
@@ -742,9 +740,6 @@ doc: DPLL subsystem.
             - measured-frequency
 
       dump:
-        request:
-          attributes:
-            - id
         reply: *pin-attrs
 
     -
diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
index 3bdabbf2b931..fa09b524a4a0 100644
--- a/drivers/dpll/dpll_nl.c
+++ b/drivers/dpll/dpll_nl.c
@@ -65,12 +65,7 @@ static const struct nla_policy dpll_pin_id_get_nl_policy[DPLL_A_PIN_TYPE + 1] =
 };
 
 /* DPLL_CMD_PIN_GET - do */
-static const struct nla_policy dpll_pin_get_do_nl_policy[DPLL_A_PIN_ID + 1] = {
-	[DPLL_A_PIN_ID] = { .type = NLA_U32, },
-};
-
-/* DPLL_CMD_PIN_GET - dump */
-static const struct nla_policy dpll_pin_get_dump_nl_policy[DPLL_A_PIN_ID + 1] = {
+static const struct nla_policy dpll_pin_get_nl_policy[DPLL_A_PIN_ID + 1] = {
 	[DPLL_A_PIN_ID] = { .type = NLA_U32, },
 };
 
@@ -133,16 +128,14 @@ static const struct genl_split_ops dpll_nl_ops[] = {
 		.pre_doit	= dpll_pin_pre_doit,
 		.doit		= dpll_nl_pin_get_doit,
 		.post_doit	= dpll_pin_post_doit,
-		.policy		= dpll_pin_get_do_nl_policy,
+		.policy		= dpll_pin_get_nl_policy,
 		.maxattr	= DPLL_A_PIN_ID,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
-		.cmd		= DPLL_CMD_PIN_GET,
-		.dumpit		= dpll_nl_pin_get_dumpit,
-		.policy		= dpll_pin_get_dump_nl_policy,
-		.maxattr	= DPLL_A_PIN_ID,
-		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
+		.cmd	= DPLL_CMD_PIN_GET,
+		.dumpit	= dpll_nl_pin_get_dumpit,
+		.flags	= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
 	},
 	{
 		.cmd		= DPLL_CMD_PIN_SET,
-- 
2.55.0

