Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793355254;
	b=5FZux3SZU6XC0V7qBnCrft/pW2GONazzDzOsX9zguUomtHra4EpwLvQzvDqMMietD99Y
	 VEJoOTSc5mxnP6wljOcsFRSHAF8tKfx0vo9QrKE6blbhSNDh1ZQX58ncQCQI/3yc/Atmu
	 GPUBVbpFPVIYPZVBT4eiw2SptuyFqGmNXnNLyjpZ5KCrKMfNNqI7i4L3qnYd7BdwrhiZf
	 E6/d/Y8jedHDlZ8fJ1rQwKqCAr06BP03+YzEGGtQpd8bNW5UdAoEJxTd5rQ5BGNe969w+
	 gUwFF3Y+jRv95GrZCggXQ5dEyFNql65UUzv03s7bxXNFljVKu/Bmmn08nhwgLFTQIjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793355254;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Zk7O+18laJ6xepmT73CywoOPP+vRhvPaCfcZahdMOQE=;
	b=JZPz5SM8BqNkSkZJcbg3M1RI6dXIZZc+KilSjX4PzmR9mpPxdWmoqZbbnp2dXytElQRL
	 hNqAWGO4509o/ESWibadE9jVFhwPZbfnuZsWXQmeSV7GLcp1OTQ3zwPupxiwj2RTtlH+s
	 McKhinsAYivc6TE+01CUV/UoVqWVnsW540d5hwDi/pKjXta3jz9sIPgdGLDDb92Tc/yyW
	 NpPlxGqV8yPR33z+HXFAAaZq4kD2RbiuQxk28FudVuF5Ve7toWph1QMXRbFeiz0VrFcy3
	 8sF+J9RqzXwn9gGH9B21gXIG9NGk/kblHMOug5Y3+GQA1GdbEGrfKxndemQknCXRPzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=6wind.com;
	spf=pass smtp.mailfrom=6wind.com;
	dkim=pass header.d=6wind.com header.i=@6wind.com header.a=rsa-sha256 header.s=google header.b=cFhtbjeJ;
	arc=none smtp.remote-ip=209.85.208.98
Received: from mail-ed1-f98.google.com (mail-ed1-f98.google.com [209.85.208.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6F3606A31A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 10:14:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE6F3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=6wind.com header.i=@6wind.com header.a=rsa-sha256 header.s=google header.b=cFhtbjeJ
Received: by mail-ed1-f98.google.com with SMTP id 4fb4d7f45d1cf-6aff2e5b322so88236a12.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 03:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1793355252; x=1793960052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zk7O+18laJ6xepmT73CywoOPP+vRhvPaCfcZahdMOQE=;
        b=cFhtbjeJ3TqQ44NNXbS8ft/dBIPIjqQnG+3hkY3PSdXlaWqC9I9dO7SBuQLFFrd+mq
         WQmxMKyY4sHs00CqD7W1XfTHftFZ50XYNcyOb1pBTmiTaMAI+5ka7Ty3X5ZkWqVdsFHJ
         570VcNgfffM7UPIQtXa+/Au0iwV/38lLSBpb3Fui2YyFy+Q3RFHBDRdWBBoq5RQJAsEs
         nf1EgBqD/Z3SP4kQ2pXCUVKr/4nlaQ00XMjGfSFA+NejmzNb7WZVm0J9ka9kKHYoSzAz
         OHRZ4PbWdRE+4PG16c/QHB/lormVw7WG9/TKWBTNttmh428N8eyFafvTOfYfQJ2E7WCE
         gzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793355252; x=1793960052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zk7O+18laJ6xepmT73CywoOPP+vRhvPaCfcZahdMOQE=;
        b=b+/fB+7RaSgTNk4Lf7pnOgN2wG1FI3bgQqGE44eh12N9okjQvTZlyGqMKS0uLMBkwY
         ctNViUKeN5Cial1cKXDdJTxrvwsoIk0NI6gdLRSZUjGnhh5rwedMjskvt/vi7o7mQXFp
         mpq29A/rq4RsZEPWZghuPSZC6l6b6XWi6JlE/FONfFW1ab5ngZ2N9NpMdHcVvkxLMLnQ
         nLd+oSYd4Iyfc3cdyvftw/ndqdl1Roo+rKiso95yHmOw2NXHdki/KrKBywUxa7qcpW2L
         cRe75BHLkFZcmr0v3/cPfcIRJX478mC4yhsWJPCWfy9no5hN5Xo540xpWDqul9IQj0DT
         BzAw==
X-Forwarded-Encrypted: i=1; AKwUvBzwH/TINqYST8lLCN804Tk6ed2g9/DpjTnUWxFN9oBZYa9Ad1vmzs5Ww8TBKbMx5yR66AjAyQ4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIAwJOUjjymCpQhZAj0x18QrXiiZ+XqSgR/xWfc2rFJLbxAbRdH
	Ueg/71lXqWpvJ6IQxq8B8KrZeWZC/cu12Pn/p5vRH3q0fxlxllbt+3rDLcPAPdl1KL77b78AnA4
	Wz7oqRLpf+vGiBMxuobOn0mm+ztmIyK9zIqUF
X-Gm-Gg: AYBFou3z+2NRH3qy/dNz1N33vgg3e22fnn8aKDeoRVkcQLjFpaCbsIeDt++pE77n/gM
	j/viaHuTN7jzek7k4F5C8yny579Yemyqm4uE/0ttKW/2RDFdvhEGx65al3PKL3/Wbh4sRJE/6wA
	SQPnIgGmVGsxjx73QugOHchpAduCkmdWbE27uyvqzoJYV0/CHaAJQwaXm35DPPVHkKrbkCkaSOf
	gbzgzm4Z2hqOdMujPCSIGWx+ORe1A4YdPNXWcYGBZUVmfqQh5F/sNRCnO3faem016eCYzmrt8Zf
	LVXSn5udMIHI4aoiReVFeJxKMfYFemWgJkyFwvFFMywC2aPpClreK7q66elOpUPi8B1uGiMpn2o
	DkD3iAblmWT8LGsZ+MYrXKzsxvg==
X-Received: by 2002:a05:6402:f16:b0:6b1:bfa2:28b9 with SMTP id 4fb4d7f45d1cf-6b4d466f8d6mr1301453a12.2.1793355252160;
        Fri, 30 Oct 2026 03:14:12 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with UTF8SMTP id 4fb4d7f45d1cf-6b4d7a4f16fsm307926a12.2.2026.10.30.03.14.11;
        Fri, 30 Oct 2026 03:14:12 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from localhost (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with UTF8SMTP id D36D411016;
	Fri, 30 Oct 2026 11:14:11 +0100 (CET)
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: David Ahern <dsahern@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH iproute2] ip-xfrm: add support for XFRM_POLICY_CPU_ACQUIRE
Date: Fri, 30 Oct 2026 11:13:59 +0100
Message-ID: <20261030101359.1907972-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.47.3
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

This flag is used to enable RFC 9611. The corresponding option for states
is 'pcpu-num', see commit b544c7c5c7cb ("ip-xfrm: add pcpu-num support").

Link: https://www.rfc-editor.org/info/rfc9611
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 ip/ipxfrm.c        |  1 +
 ip/xfrm_policy.c   |  4 +++-
 man/man8/ip-xfrm.8 | 10 +++++++---
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/ip/ipxfrm.c b/ip/ipxfrm.c
index 586d24fb8594..78d9e1929760 100644
--- a/ip/ipxfrm.c
+++ b/ip/ipxfrm.c
@@ -1094,6 +1094,7 @@ void xfrm_policy_info_print(struct xfrm_userpolicy_info *xpinfo,
 		fprintf(fp, "flag ");
 		XFRM_FLAG_PRINT(fp, flags, XFRM_POLICY_LOCALOK, "localok");
 		XFRM_FLAG_PRINT(fp, flags, XFRM_POLICY_ICMP, "icmp");
+		XFRM_FLAG_PRINT(fp, flags, XFRM_POLICY_CPU_ACQUIRE, "cpu-acquire");
 		if (flags)
 			fprintf(fp, "%x", flags);
 	}
diff --git a/ip/xfrm_policy.c b/ip/xfrm_policy.c
index e60acd5bb98f..5261a292f468 100644
--- a/ip/xfrm_policy.c
+++ b/ip/xfrm_policy.c
@@ -61,7 +61,7 @@ static void usage(void)
 		"PTYPE := main | sub\n"
 		"ACTION := allow | block\n"
 		"FLAG-LIST := [ FLAG-LIST ] FLAG\n"
-		"FLAG := localok | icmp\n"
+		"FLAG := localok | icmp | cpu-acquire\n"
 		"LIMIT-LIST := [ LIMIT-LIST ] limit LIMIT\n"
 		"LIMIT := { time-soft | time-hard | time-use-soft | time-use-hard } SECONDS |\n"
 		"         { byte-soft | byte-hard } SIZE | { packet-soft | packet-hard } COUNT\n"
@@ -139,6 +139,8 @@ static int xfrm_policy_flag_parse(__u8 *flags, int *argcp, char ***argvp)
 				*flags |= XFRM_POLICY_LOCALOK;
 			else if (strcmp(*argv, "icmp") == 0)
 				*flags |= XFRM_POLICY_ICMP;
+			else if (strcmp(*argv, "cpu-acquire") == 0)
+				*flags |= XFRM_POLICY_CPU_ACQUIRE;
 			else {
 				PREV_ARG(); /* back track */
 				break;
diff --git a/man/man8/ip-xfrm.8 b/man/man8/ip-xfrm.8
index 4c278ccba38c..50fbb1a7d93d 100644
--- a/man/man8/ip-xfrm.8
+++ b/man/man8/ip-xfrm.8
@@ -376,7 +376,7 @@ ip-xfrm \- transform configuration
 
 .ti -8
 .IR FLAG " :="
-.BR localok " | " icmp
+.BR localok " | " icmp " | " cpu-acquire
 
 .ti -8
 .IR LIMIT-LIST " := [ " LIMIT-LIST " ]"
@@ -674,8 +674,12 @@ is a number that defaults to zero.
 
 .TP
 .I FLAG-LIST
-contains one or both of the following optional flags:
-.BR local " or " icmp "."
+contains one or more of the following optional flags:
+.BR localok ", " icmp ", or " cpu-acquire "."
+.B cpu-acquire
+enables per-CPU SAs (RFC 9611): the acquire messages generated for this
+policy carry the number of the CPU that processed the packet, see
+.BR pcpu-num "."
 
 .TP
 .I LIMIT-LIST
-- 
2.47.3

