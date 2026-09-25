Received: from mail-pj2-f25.google.com (mail-pj2-f25.google.com [74.125.227.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C07C4E06DD
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 16:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790354510; cv=none; b=qXsFcauQh06JqJRDL2skSv9PYpxMoZ2hM6WUOa3I6PqikNud3QCNY720kNDiAstPDLq0p/aD/kWMHoa9nxvbeZa+svsel6B4vU9zUULqAdSSsM66kHidwZVrBLQyOHSPMtegg0WpIduNn8XazsQtcA26ba1Wj9soNbU7pf2NZi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790354510; c=relaxed/simple;
	bh=TtrcUjfhGxN+/Il9E+zFlb127nCYs18NSgDSKBIiHpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TN6IeRKurzCTsZYA12M3WBwkmmvR63JBVTYKlnQ+znRUSo9qYtZcnDqEUKkJ/BhtAm91qZlpcCjWPySXjWqFUIg7QAqcADeFVvnWoc4KRbech2D/qGUCGL2SGCS/9QcNgAuji90WgJtSmzUfmVzoe4hdFX1z7emZXn0dR+LsMx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=iJ+EAK6T; arc=none smtp.client-ip=74.125.227.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="iJ+EAK6T"
Received: by mail-pj2-f25.google.com with SMTP id d9443c01a7336-2dd4b43b20bso4764155ad.1
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 09:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790354483; x=1790959283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6hQQWvTzGmogv0EMa2VjHO6aB1rZOWzNyIYZn2ueb1k=;
        b=iJ+EAK6Tjdequ3S+h5hPGfQbsMqbmfJT7FDq2pnWNrnK23ZhbpKwx4DqzclvIKVMqn
         ZyBZeXIv9FLiqzYu3OU+jlbwubQsqJHZxpGNwvvgFosXIVdLqZM1Hg+PTv/GQvjE2nI1
         odhYpfnranEYpmHuVqgZK1CaS5EASEtI2/9XiZSccNfrW85cWD0fosvQjOXi7os0kN71
         wMTogkmpcKCh21LaVCYmbCowjf6uU+k0+0ZbCntlgAbGuCbbFZDlOGCjzGFEALkjyzYx
         EWZ7QUQFRLi+yx+aIB/xOZgKMXzK5bSxRfowsV77jopGTtE0+AKUg4nnvbf8qNBZ0Yll
         M9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790354483; x=1790959283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6hQQWvTzGmogv0EMa2VjHO6aB1rZOWzNyIYZn2ueb1k=;
        b=TX+vLqzRCey+aUk5yA8F/JfYMfyrQnfFAyYaDlLk0JBPCYE4bZ1a+7C1hFCCE8dBZQ
         SjgzbH+5bM+gt/dMN4sJUWj3Ew6bzvTcSdxXlnNt2zW7G+q7/7kowcQEro13/yJF4dRv
         sk0fWIQtoSs++yofA1swpmeW8oVMNZLabxsb1FXiSWwCDTKmO9CdtsQBcc0jQK8l7psW
         /rpHVY/LmzgJhKZbeZc+eynKduKNsyAHH+K6MQ7+8BK67MFMV+65Wv86C+iby7uyreMF
         BrMY7U/q9X/e6K8iwEF/NwFEIbgSLythapxPB8gZFc+bHKQJ4EmC1GJzwY2n5f9gBLrS
         b8Og==
X-Gm-Message-State: AFuF++mDcYEKI2ezBAFnNFu+YiFTd+qeLUj+6dHwjLdbs3znV4Hdbd3G
	84JI4cHOJfhOi/kkVMkEyDagMLkaLCrBSWId+pP7pzOkI9ZrhOg3LCKdTep94+HG+jk+jq3YTml
	D0IzmczTo
X-Gm-Gg: AYBFou2QEOBsC732ER9H4d9MgVki47hzOEJhJG5squpBfCBJOvwiNbORn5aO+t3vG66
	d45+UL80VWDrWd2h6/1uRGYmniyjWFtZ87+3bDxiImXTvQP5s8sbvrDjs/pjz+QWlTD3BiAVhOe
	Av80CACvaa0oZSRNjxzwRpA0Tx9amLp+tAXxjnYwsBTN93/thDN4UajNfweL9S0hawYZKCkpHXE
	xXfkBqQ8WUd4aAZEJRkRnCNoVqJJ7HGTYCP5U1/cdTnw/MwlT05Cf/Fss19eGIwTGOVsqeBgd3x
	tVXWJ3ncA9VzRynpevgiOa5aQ0p8bTDYz1CxP3sE1GFZNTf5IidRghLhnU+349rKIy4YlnDgFbV
	ZO7VeUtybm3oMBc6Xdv3P+/unu0JN4+eTYzra+qJ+si8EgtbnS+r/mHwi7OBJUXB3vEmfy7czni
	XPOH0lkIph5r3FdKDn3WE5SgQZaZZWAllwRL8/w9qDyB7w3T6bz+N+VXREb/4nLtqiuNGzvhA1m
	Uwkju0k8h4spa/NbpDIvAmqc6J9pd77iQ93BG2l
X-Received: by 2002:a17:903:1447:b0:2dd:c053:ec73 with SMTP id d9443c01a7336-2df7e11ad13mr46713485ad.38.1790354482412;
        Fri, 25 Sep 2026 09:41:22 -0700 (PDT)
Received: from 954df21a5119.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df9146edb4sm13855275ad.81.2026.09.25.09.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 09:41:21 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	netfilter-devel@vger.kernel.org
Cc: horms@verge.net.au,
	ja@ssi.bg,
	pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	zihanx@nebusec.ai,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>
Subject: [PATCH nf v5 3/3] ipvs: reject FTP control ports as data ports
Date: Fri, 25 Sep 2026 16:40:48 +0000
Message-ID: <a1fcb8b49e266e1cac9cce78498842167ae0f2a3.1790266803.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1790266803.git.zihanx@nebusec.ai>
References: <cover.1790266803.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip_vs_ftp_out() creates a wildcard data connection from the
server-advertised passive port. If that port is one of the configured FTP
control ports, ip_vs_conn_new() binds the FTP helper to the new connection
again. A subsequent wildcard lookup can then extend a controlled-connection
chain.

Reject zero and configured control ports before creating passive
connections. For active mode, reject a zero client port and a data port
derived from a configured control port.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v5:
  - Rebase this patch on Julian Anastasov's v3 timer-callback fix.
  - v4 Link: https://lore.kernel.org/all/cover.1790146910.git.zihanx@nebusec.ai/
changes in v4:
  - Resend the FTP helper fix as patch 3/3 with the generic cleanup fixes.
  - v3 Link:
    https://lore.kernel.org/all/cover.1789877273.git.zihanx@nebusec.ai/
changes in v3:
  - Keep the active-mode guard for configured FTP control ports.
  - v2 Link:
    https://lore.kernel.org/all/cover.1789435989.git.zihanx@nebusec.ai/
changes in v2:
  - Add the active-mode check for a data port derived from a configured
    control port.
  - v1 Link:
    https://lore.kernel.org/all/cover.1789110326.git.zihanx@nebusec.ai/

 net/netfilter/ipvs/ip_vs_ftp.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/netfilter/ipvs/ip_vs_ftp.c b/net/netfilter/ipvs/ip_vs_ftp.c
index 9e3e005a82635..4822a1a75212d 100644
--- a/net/netfilter/ipvs/ip_vs_ftp.c
+++ b/net/netfilter/ipvs/ip_vs_ftp.c
@@ -62,6 +62,17 @@ static unsigned short ports[IP_VS_APP_MAX_PORTS] = {21, 0};
 module_param_array(ports, ushort, &ports_count, 0444);
 MODULE_PARM_DESC(ports, "Ports to monitor for FTP control commands");
 
+static bool is_control_port(u16 port)
+{
+	unsigned int i;
+
+	for (i = 0; i < ports_count; i++) {
+		if (ports[i] == port)
+			return true;
+	}
+	return false;
+}
+
 
 static char *ip_vs_ftp_data_ptr(struct sk_buff *skb, struct ip_vs_iphdr *ipvsh)
 {
@@ -319,6 +330,10 @@ static int ip_vs_ftp_out(struct ip_vs_app *app, struct ip_vs_conn *cp,
 		return 1;
 	}
 
+	/* Do not redirect data to control ports */
+	if (!port || is_control_port(ntohs(port)))
+		return 0;
+
 	/* Now update or create a connection entry for it */
 	{
 		struct ip_vs_conn_param p;
@@ -529,6 +544,9 @@ static int ip_vs_ftp_in(struct ip_vs_app *app, struct ip_vs_conn *cp,
 		return 1;
 	}
 
+	if (!port || is_control_port(ntohs(cp->vport) - 1))
+		return 0;
+
 	/* Passive mode off */
 	cp->app_data = (void *) IP_VS_FTP_ACTIVE;
 
-- 
2.43.0

