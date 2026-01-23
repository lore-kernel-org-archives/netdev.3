Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13394314A95
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 07:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769153822; cv=none; b=LYFhs/E81Qo89Ti/zpODwjcxr7NB2ib7foVmqHFt7fFNbEVe42RYFUHR0Sibh90JnuNanLS6rdq5MOPjr8TKOqOZTWdlITwInWNF85lwtxmm6YO2xZ1G4G8wFv9JLScQKPVfNgFAtStsA5pN1F7EAgJzsCdeFom6uCD1OX86i8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769153822; c=relaxed/simple;
	bh=pPH6IGYSvT73W3XnsSk5F+V+bv692q4Zq0EDWpqk/mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=svHpPHkeeJImjhTpP2Dh+dg3yGN3YIGU5TtdmPVytPCsBex1q7Jjd5WO9zGHq0HiAi6yNzdkue6ULVbYoBNj8yivY1POT0Iiv0g//fvAm9ey+fHUaFpE6PpmWb8cM+vQ3OzYtu4bxWF04R0xUBScPBY9ZZ2NgJ3Vc1w9dYVU5no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vm0+fqpH; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vm0+fqpH"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-8217f2ad01eso1960280b3a.2
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 23:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769153820; x=1769758620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGHQu6mG6lMqPEadRM+ZfBOS3CsIq7QGGssQ90tpvv4=;
        b=Vm0+fqpHWlEa2M1hAWoc9wyZcQl+HMEfYOUmXMKu/0JcRr/8K92M2mH9/A+O3FfeHm
         moFr8zJZgMZLQOP3uH0OppnTFpsVWGMV3qCgDUb7otpHQJ6gy4JDMPlp3ucLeVbVk2lg
         J8nZnxX5a/+7+QNkXtJKNX7HORm2gkiygY1LfofMVgFsSxRZAv9UGHKTscqCGclkHu9H
         atp+gRwiHrtbtArlApz7oxhleB4h9HE53LORlO5syHT9wx2XsQUZOPhaCBavdRzLME5a
         1hybaCeuKmtcZnIlOpmbN1gFJxtARI5UPYMWNgN3sOXwPMsxMyIsGO382ggec3+6yXnH
         dnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769153820; x=1769758620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BGHQu6mG6lMqPEadRM+ZfBOS3CsIq7QGGssQ90tpvv4=;
        b=g/RoGLx/6+Xxpnh0lcEkTvdTSb+oTBIL7P77BkhiWiht/sb/FzTm4gX9H5apHrTTal
         AAkC+HC/OsZjXhg7FtPUIi3jvWXjFjWDP+ah5g+k0Z1uLkPZQX4SEwVy9mrTyIzyuphv
         0zUrgySNNoTV5ywSHu9q5M+voT0gdDZHTcIup2jq81b+E+5O2rMI7KjqPwMH0iv7CvZb
         JtLE7J2aqoG/azr/SS/tvbZ0tQXL8U6tmKTVXxJAQtRjN7YIrGgrTgcvEq+WQaxJG+Pt
         z6ehAmN4vPnSKQ1jyZiBWb+tuHB1p6MoheILoZmzqmSy5bYNrO8SWiL8d0qtv1ugRNsn
         m5tA==
X-Forwarded-Encrypted: i=1; AJvYcCXzdQRnEFbpqOHrsl6skzbYBEoVdegqBoZHJ6cT3jW8apbHRVlyurcqgFO695n8ou7Zs4S2/TE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgrvQUrpPC2Hxs/e5nVTt13lScx1os4zSpvjvb0ZR4N1JRToRj
	bFzwEwLTP0akFRLRKmwg5D5SMzVO44U59DvEhB6va96nsfQ6QzCqvIQ/
X-Gm-Gg: AZuq6aKM5lhHsWQxVOjGpNYa/tU0pG3+KQ21Urp4qFG2GElf/KBHJnk1N1FCZ9hUIch
	jU/3kHzLh2PoM27CbDArEH1ZvE7s9gZp1YTSAZEXSvZ4Kp+RHUOhcbtSz28Wjg6wP/2Sr5aSeCz
	4YVIr4k7bE0HDrPBB+VKo+/tfD+S3Hl9lvf0zS5t/POLClUxPkCVR1LsPjILS17/yMlUYJ9UOOO
	ej14ANjT5Q2NFFFNK6uGfWxOEhNsSj0OPWSfodk14g5iwX1/Lma+gZWn50OH7k/YYgEE0QwYAp7
	l9tAl4WO1S3+gPRHqK+K4ujE981COipRUj5y+VcJ31kmWlrAw3huI5E7/9swA4Nv3k9bnUT18Uk
	oh2J080z4k6k0r2MOnKYlCoGEX+D0eueGPFMUqVRptOmbqHL2kxaHWktV03TYDInl0+zQgjRxGR
	MTxGsycS7k
X-Received: by 2002:a05:6a00:3c87:b0:823:bbb:76fb with SMTP id d2e1a72fcca58-82317ecf202mr1711766b3a.46.1769153820320;
        Thu, 22 Jan 2026 23:37:00 -0800 (PST)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231876fd1fsm1334205b3a.69.2026.01.22.23.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 23:36:59 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	jiang.biao@linux.dev,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v11 09/12] bpftool: add fsession support
Date: Fri, 23 Jan 2026 15:35:29 +0800
Message-ID: <20260123073532.238985-10-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123073532.238985-1-dongml2@chinatelecom.cn>
References: <20260123073532.238985-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add BPF_TRACE_FSESSION to bpftool.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 tools/bpf/bpftool/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index e8daf963ecef..8bfcff9e2f63 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -1191,6 +1191,7 @@ const char *bpf_attach_type_input_str(enum bpf_attach_type t)
 	case BPF_TRACE_FENTRY:			return "fentry";
 	case BPF_TRACE_FEXIT:			return "fexit";
 	case BPF_MODIFY_RETURN:			return "mod_ret";
+	case BPF_TRACE_FSESSION:		return "fsession";
 	case BPF_SK_REUSEPORT_SELECT:		return "sk_skb_reuseport_select";
 	case BPF_SK_REUSEPORT_SELECT_OR_MIGRATE:	return "sk_skb_reuseport_select_or_migrate";
 	default:	return libbpf_bpf_attach_type_str(t);
-- 
2.52.0

