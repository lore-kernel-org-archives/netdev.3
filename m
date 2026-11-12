Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513655;
	b=oQ7LlPuERX2GnHa5Cv5aiZVm3zBljrM7Pg9DUEbsLwHl3Nl8fuSg9ojQlR4Yq35Cz7ww
	 HD9EGSJOMpd2A5ulA7jSUfUJcDt+cpJ4eIVF+lSAV3FCd3tcQpMIzl66lgeXj7BCZmgGn
	 w/o5YukNoNRuh3iisNS0JZ8xT7AfmOF8zbsdvVdY7xIRQPdPcjLMJMSpGWjbQj16uBfl1
	 Yn46ixMa+j8junU0/3ocLbyS7lS8xn0KdtNNuWDMvcFw1jJzT4hlWnwagE0ZiO/emShmc
	 GStUAwZEQhnrCqN1IMmmSf1tcOAS64Wzvt+N6DEVrrBWJDg8IK27yGq+g0fKPKadStA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513655;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VC4OdCe/LgNXkhGsk/CkX5+khBmZwetPRhu0LmQOFU8=;
	b=XPZjcXLknI2aVscrc46NWPIsGG02OfYIqgdWRukrwMHVrlQ/4zUSpaVEIHiTumABWp1g
	 q4L4rjDpn07MsT3/vUmnuyq7DlAxue+3NWbKmNnefBCI7R/fz1wWF4LG4u7xiVFIsC72T
	 jH8/LPXSOSjDZs4ObQejqxP76/d9/p3/8d/pXlFrtDK3ZW7FrrpTdRjj6LAr3dTGCbWh+
	 Tnhmg7v05V7HrgOtORLcUICKY9RRp1b5eH7X+sY1jRSUBR6+4N9VFKYLSlhPP6Ia3N59L
	 XjSQW0Ek+R9G/iAuPNWjcfiBK582vJ+Uid5mTH+S1WDnT/i7B2IYkUVA7zs2tyLaWFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=aB0YClp0;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5BF606A89B
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 20:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B5BF606A89B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=aB0YClp0
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b197cd42b0so115165a91.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 12:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794513654; x=1795118454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VC4OdCe/LgNXkhGsk/CkX5+khBmZwetPRhu0LmQOFU8=;
        b=aB0YClp0iRns3+mhb3zaiD6d62FTcvq4j/pAzX79GLTIJT3uL8ISkTLSZAzTR7kGYI
         WAfLsyG0F5HBysm9wWYi3p11hmZDr004ahbjaxWJCOZ/27lBu97q+dtcRIKit6cY8syK
         narpVnWEKrWGkaj9ZBWklrbN9Xy5upfox8xh+2I371FavWrxc8GCH9h/GKaOFFHHK1Zs
         o1WZlBt8AUkqX7aa0gPqgXKWxgjg+J4JXxxClIQvR7NzSAb5veAp3olakvcWFsuhiQQ9
         1MFeWpxZHyZXumSDxNvsHqcz/6JThyeg0PYTLJSrugC1Xd/BGvofoIi3XJSEk2Z5H9Gj
         ShTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794513654; x=1795118454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VC4OdCe/LgNXkhGsk/CkX5+khBmZwetPRhu0LmQOFU8=;
        b=idWL9llGNQ/TpctZBN4z6Na/thjr2NLmLJkb20lNcBhEGvwVwr2fgRj3NWQPQkCvSx
         C8gYnnr1iEeydx5POd6thAMa+6UoicJk35VGnn6c3sj/gg+MHn6gBcQGojrztzY/q78S
         fOOUDoHpwc3NqogdKFFJ9MQ6dKLKqNRNbs47kdCJBqUZB9unKarpxz2ptAk4qKEI/+hY
         lWThNbniJ0Z6EjiAn80YmN05O6U8coMiSRhN+PTbUMJVMfl9XrmJQEP3fDu6+ipt4gUJ
         2CIvXID1bdgWnawQb+qLNic7hG/5dDl/jxluVurzxgRfrgz1YYW40Xp0R/kNmWT57KrQ
         Zwpw==
X-Gm-Message-State: APuU4Z+1321+bitVt5tbomFMmeo/U/x3IOF8tStQKE6opmViQ6EX7oXE
	UIAxl3rhX8SUOHz8wV9NVTzGJZIEZdG0Q4PSPvMRuvB+ug/ouT0RKUWE785SsrI7dlwHvEW+AOR
	6jM69
X-Gm-Gg: AYBFou3dC987hqyrPEjHkVW+HQD92Cgz+oYbNXIgAr4DBjuyGebO5kz8scCxdroVI0/
	FBmzlxoobmLEMbANYT7iMBuZSDt39+WpkuKmpZhmLw+WNM/xN2dKmRruYWAdIW73TzpojAb42zA
	OmLjTeR7Bz/6nGLqGLD99SIp63GW3CxY3xeHO4BfAXl07lLL1F6/WVRAB3LB32A3Xpw0q8BwOuw
	znsgpagVmRbF8ot94Z8UF7nqZ92f5xC/erkACL93PVm8ixg73eagy5v/s768iH4CfdGBAnmdMCt
	R++YV5jTbvlnz8NIpbt17GEXanbzANggohPOt3j2h9QLg7MGca0mo50yA8hJ53dxs/HPqI+uPq0
	jMYyCUi+bTkFRcrMrCUhkP2KHvJfXPashHtgSraCarGyuZHO6C26k5mnghRB3uOMFB54UO4nYrv
	F/39UIXvkJ68HSm3hK6523NDERTa64AE1BrsaMBrpBtBQ2qMj11ZcEXFNap7HGfQQpUXa2xTifu
	IbB70uQ3Mc82lgdXP9huQ2HW5pQ6zwh6B8PAd04+39NzxXfQDLk0VnJkgwswUR1YBcVjcloKjrR
	9iuPCRQ61/FYbTOkAOLuT+pEq2LeoIskrYRq9XkCo20IPogbzWt0pfjzPDPhHiHw4a9jPcA=
X-Received: by 2002:a17:90b:2cc3:b0:3a8:13d6:f740 with SMTP id 98e67ed59e1d1-3b1b0a0d989mr134212a91.22.1794513654245;
        Thu, 12 Nov 2026 12:00:54 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d27d26sm5967123a91.13.2026.11.12.12.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:00:53 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 06/11] ss: bound state and type name lookups
Date: Thu, 12 Nov 2026 11:59:19 -0800
Message-ID: <20261112200046.2164391-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112200046.2164391-1-stephen@networkplumber.org>
References: <20261112200046.2164391-1-stephen@networkplumber.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The socket state, SCTP state and TIPC socket type come from the
kernel (or a TCPDIAG_FILE) and were used to index name tables
without a range check.

SCTP associations were detected by the inode matching the previous
row, so an endpoint dumped twice was treated as an association and
its TCP-style state indexed the SCTP table out of range. Use the
INET_DIAG_PEERS attribute, which the kernel only sends for
associations, instead.

Reported-by: Anthropic OSS scanner (ANT-2026-GDQ1INKZ)
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 misc/ss.c | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index 72de0742..2becb852 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -107,7 +107,6 @@ static int show_proc_ctx;
 static int show_sock_ctx;
 static int show_header = 1;
 static int follow_events;
-static int sctp_ino;
 static int show_tipcinfo;
 static int show_tos;
 static int show_cgroup;
@@ -766,7 +765,15 @@ static unsigned long long cookie_sk_get(const uint32_t *cookie)
 	return (((unsigned long long)cookie[1] << 31) << 1) | cookie[0];
 }
 
-static const char *sctp_sstate_name[] = {
+/* Names indexed by a value from the kernel, which may be out of range */
+static const char *table_name(const char * const *names, size_t n,
+			      unsigned int i)
+{
+	return i < n && names[i] ? names[i] : "UNKNOWN";
+}
+#define TABLE_NAME(names, i)	table_name(names, ARRAY_SIZE(names), i)
+
+static const char * const sctp_sstate_name[] = {
 	[SCTP_STATE_CLOSED] = "CLOSED",
 	[SCTP_STATE_COOKIE_WAIT] = "COOKIE_WAIT",
 	[SCTP_STATE_COOKIE_ECHOED] = "COOKIE_ECHOED",
@@ -805,6 +812,7 @@ struct sockstat {
 	char *peer_name;
 	__u32		    mark;
 	__u64		    cgroup_id;
+	bool		    sctp_assoc;
 };
 
 struct dctcpstat {
@@ -880,18 +888,6 @@ struct tcpstat {
 	struct tcp_bbr_info *bbr_info;
 };
 
-/* SCTP assocs share the same inode number with their parent endpoint. So if we
- * have seen the inode number before, it must be an assoc instead of the next
- * endpoint. */
-static bool is_sctp_assoc(struct sockstat *s, const char *sock_name)
-{
-	if (strcmp(sock_name, "sctp"))
-		return false;
-	if (!sctp_ino || sctp_ino != s->ino)
-		return false;
-	return true;
-}
-
 static const char *unix_netid_name(int type)
 {
 	switch (type) {
@@ -1437,14 +1433,14 @@ static void sock_state_print(struct sockstat *s)
 		sock_name = "unknown";
 	}
 
-	if (is_sctp_assoc(s, sock_name)) {
+	if (s->sctp_assoc) {
 		field_set(COL_STATE);		/* Empty Netid field */
-		out("`- %s", sctp_sstate_name[s->state]);
+		out("`- %s", TABLE_NAME(sctp_sstate_name, s->state));
 	} else {
 		field_set(COL_NETID);
 		out("%s", sock_name);
 		field_set(COL_STATE);
-		out("%s", sstate_name[s->state]);
+		out("%s", TABLE_NAME(sstate_name, s->state));
 	}
 
 	if (show_queues) {
@@ -2498,7 +2494,7 @@ static void sctp_stats_print(struct sctp_info *s)
 	if (s->sctpi_tag)
 		out(" tag:%x", s->sctpi_tag);
 	if (s->sctpi_state)
-		out(" state:%s", sctp_sstate_name[s->sctpi_state]);
+		out(" state:%s", TABLE_NAME(sctp_sstate_name, s->sctpi_state));
 	if (s->sctpi_rwnd)
 		out(" rwnd:%d", s->sctpi_rwnd);
 	if (s->sctpi_unackdata)
@@ -3622,6 +3618,12 @@ static int inet_show_sock(struct nlmsghdr *nlh,
 	if (s->local.family == AF_INET6 && tb[INET_DIAG_SKV6ONLY])
 		v6only = rta_getattr_u8(tb[INET_DIAG_SKV6ONLY]);
 
+	/* SCTP assocs share the inode number of their endpoint; only
+	 * assocs carry INET_DIAG_PEERS, and only for those is the state
+	 * an SCTP_STATE_* value.
+	 */
+	s->sctp_assoc = s->type == IPPROTO_SCTP && tb[INET_DIAG_PEERS];
+
 	inet_stats_print(s, v6only);
 
 	if (show_options) {
@@ -3709,7 +3711,6 @@ static int inet_show_sock(struct nlmsghdr *nlh,
 		else
 			tcp_show_info(nlh, r, tb);
 	}
-	sctp_ino = s->ino;
 
 #ifdef ENABLE_BPF_SKSTORAGE_SUPPORT
 	if (tb[INET_DIAG_SK_BPF_STORAGES])
@@ -4918,9 +4919,9 @@ static int tipc_show_sock(struct nlmsghdr *nlh, void *arg)
 
 	if (show_tipcinfo) {
 		if (oneline)
-			out(" type:%s", stype_nameg[ss.type]);
+			out(" type:%s", TABLE_NAME(stype_nameg, ss.type));
 		else
-			out("\n type:%s", stype_nameg[ss.type]);
+			out("\n type:%s", TABLE_NAME(stype_nameg, ss.type));
 		out(" cong:%s ",
 		       stat[TIPC_NLA_SOCK_STAT_LINK_CONG] ? "link" :
 		       stat[TIPC_NLA_SOCK_STAT_CONN_CONG] ? "conn" : "none");
-- 
2.53.0

