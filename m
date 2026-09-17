Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9AF39F190
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 03:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789614196; cv=none; b=Sqn1BBBrP7A0Mo7e6IcF46OI9+QBcPg/SoSInr1Ww0+kld/5B5LUEld6jd67adjoiYpZjHUO0L9320Qv08hOgwggIK0UoI6G7GesXCs9O4TWM44D1mc8feSRlN4E0NYZUHhxzvcy1mDrin2R25vB/cCT1NmU1J+cUxJKsf+Pi4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789614196; c=relaxed/simple;
	bh=ZAnMJFfRyn/L7UjKQ6wtOpZX1ERwvLKzcxMf+sbJyxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u1DkC4NpUQqM9fG65VNfvQAohJLtd1wcdz0iBJGix/B5cveU688AC7iwKRILmwh8dqWS2Cm+WJDn9p6eLm5V0PRhS6PPGvRWtSsG8B+nmYYembD3G2+MDMEY3amF4jtQuBBJU/QL6yDReyDMAbFOtBTOQZXAecQmcJ/c7FF0BZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=ko2XybKf; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="ko2XybKf"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d90ba1d807so4116735ad.3
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 20:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1789614190; x=1790218990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bEiJ73gdk+1H2UniqJzXdx9Ojg0hZPLKGrnSs4IPJHI=;
        b=ko2XybKf+ORIdYCZGisQEx+vJ90W4rwUFC+yt/UmDoIucUX3CJlNfEx/m0E5hYYiiF
         vE3yYs7g03ua78cYT/714tTFpd+T00ig3wnoE6+NSYH70jYFyeqF4rkzXytzfYUkJo8X
         /fG5dy0XxE4zFdIRt8GglWF89aeWyPpK14Q3aK/W3Veco3WmWhwDMNUeTWp+6QMiAcTS
         641xbiHUYWoe5ffuGxAMXfFsrRfR9G0qgGvuQGLLcfAjVSVy5lolL8J5Sp7nz/TXNseI
         FjlOW51EO+2GWMPwo0rKZm/mMldNTQC8TaZ77cPHBtGFvzAgu9NpMuaTsvD9nDj0S5/P
         LmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789614190; x=1790218990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bEiJ73gdk+1H2UniqJzXdx9Ojg0hZPLKGrnSs4IPJHI=;
        b=N8w/DzvIA+5GlgQuPRSp0vmqX6kZ/8WxzVbl9SBGIiKI8e+Bc6kP5DTJkxeB1AMGaN
         BRxN+gcwdlIpCtj+EbrDjGW4DbLlylPCcX7I6Bod2katO8g/+kpJGCS7uUFhg6uyZQ0S
         K85GxtB2vbAL/iqMv+ra8n4Ora0RGK9fH0s5uuKvie9IdOii5/SEI8J/85pS2NZrA8dE
         3cQNczu0A+ASvFz5O5DRtaogvuiK0D83DYXpZlYhQaV2mIH0RctBppnWg7ey6Pmza4CI
         qGCgWJQtFr8bIuS7jJ7V18++Xc/pvKGM2lXgoekFsBW8Md2tkpcgPK9dVQUqDl4FFa7F
         tioA==
X-Forwarded-Encrypted: i=1; AKwUvBx3NrAoLWFVxZPZUlhR+3brvDwB9+i5gCid3V6w+2XPQ+gIF+kOo5w3Lt0m4SLYV9SqXCyGv14=@vger.kernel.org
X-Gm-Message-State: AFuF++kPAY7iuINv02sG2r7lQ6lfMyCYS7msMQZbUOTdqMimpAhvSrp3
	/k5wBwe6nOMAyTkJLdRr1piedP7bPWMYW87Y7qzTmvifva0IR9JlljWYzWq1s2DcQ/0f
X-Gm-Gg: AYBFou08m7KrtV3KtnPGpXtHTYFqJKm2EVU9a0i4pA6vmBOURn9Yp0hmRUVCzeuaNEI
	vd3CRgDB7D9jO4PY+/O/ZNelf0yAKlieElXb51UHBxPuF3izppP5dO4fCXoSsLpCsaxtBWN+5cd
	SbKFTuegAyMgmYyqD8PcaDlRIilsVwIbSYV0fPmUFjETVNOxq8P6yJOvXM8DcxtfzUSjrlL+7Jw
	cpBXTs0/aSvcSzepLANGLtcxDETpzJp9fkAqO6aPk1hGLAfl+yMTt93nO5C8tcaFKr/ppXHZG6w
	TX8PifVtiO+MKJGbpNk2lamkYkpiPIpxRNv43uXNAa2YCW8TCoYj4QAn2DOeCGF1Pn6WmTWEtpf
	6+KQ1kiXYiWtHnPPCj/o5UZ7sV0LF0l45l3IbVf0C3Z0CDcEN/eys3s7VzcsketBmPELvDXK+Ak
	hThw7pkglWVrw3eeKpC30/NBEetmYDgzCQHPz+7WPRUP47rEFK/gxXOka7AhjWXP7EccnbR07Ti
	zzZzZXDv7gSSmQ90EtJZg2SPQndOoT0RaDx5Ypp
X-Received: by 2002:a17:902:ebc3:b0:2d7:107c:917b with SMTP id d9443c01a7336-2dd8ccaa304mr114450195ad.0.1789614190034;
        Wed, 16 Sep 2026 20:03:10 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89f1b862sm19167845ad.71.2026.09.16.20.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 20:03:09 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: Simon Horman <horms@verge.net.au>
Cc: Julian Anastasov <ja@ssi.bg>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kernel@vger.kernel.org,
	Zihan Xi <zihanx@nebusec.ai>
Subject: [PATCH net v2 2/2] ipvs: reject FTP control ports as data ports
Date: Thu, 17 Sep 2026 03:02:52 +0000
Message-ID: <20260917030301.5502-2-zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1789435989.git.zihanx@nebusec.ai>
References: <cover.1789435989.git.zihanx@nebusec.ai>
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
changes in v2:
  - Reject the data port derived from a configured control port in
    ip_vs_ftp_in() to cover the active-mode bypass.
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

