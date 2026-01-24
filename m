Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCAD1CAA79
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 03:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769225573; cv=none; b=qqKBr1T9kgZPut4fn8+n6vYx+SUhbuRbLZtn5tOg7iwlAIhj+pXpGVVneYz52jDVPCoGSxfO7PpQekCnlnuECZ0AOsw8wZM+g718GF6nVbeLRvFbUVXrtplPvzTGWxXPTSGoXY8uUqtM7m5zc50HmE/z3i9h6uCyCPniVPzulL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769225573; c=relaxed/simple;
	bh=pPH6IGYSvT73W3XnsSk5F+V+bv692q4Zq0EDWpqk/mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WJ7PAogILUIivBpQz079sXN7PYuF8Wb+Y2LrhWTsRCbQNmdibMpzu/jPd719ijQ5lceNjM6GbVevhy4btguWh4GzQb3kn/2OgbDJmhlkbJmqvpq9ZZz6xzCR8sDrEJq/h7DfibbzZAO2U0MN7TNwl6jjITvsa8zAWNUmO3MZpeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIyIDRxl; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIyIDRxl"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a0d52768ccso20156855ad.1
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 19:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769225572; x=1769830372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGHQu6mG6lMqPEadRM+ZfBOS3CsIq7QGGssQ90tpvv4=;
        b=mIyIDRxl4rApDxd0ajsjrjciNdoE1Cov8kYTlzXYtcTUAvNU/dJ9P4NrMMEG4m+wIi
         HNIFb4+A+keoA1WI/Yzrm/j2Duf3SIztITiS0MNdKmI0XyilGMHgb6l8jvWXqND0VYyn
         TQ5U8FjIldUwicMBTNX67UR2aZmxuSqUTnUh57jSynLTWpTwl+wPM1qRh/bQ5zsyoWUc
         QSRaMvdiG2vii8kbhxXKwhUvHRTKXfq9jEejExCwSyhsia6tE3MUflQgaZk1pN6yp91E
         DfY24dbfQKXYZLuCka1EfTt33BDiDtZim5HBcnRMcCLFaLEpHo2XWhjo/+yXT1QhPQ04
         ZHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769225572; x=1769830372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BGHQu6mG6lMqPEadRM+ZfBOS3CsIq7QGGssQ90tpvv4=;
        b=HyDzkM7b+iTotsxvaj2rWNJ3bdBNuBEFGh2WsUYTv3xUWyHHBOG2UjOGmYvijNdF79
         41mPEXR6PTiRQuv3Z31GI50pl2SO+gbT9iOQjKdk3iUs+hvjo/9zSOdo/Sm07t7SmZDS
         nkbhvbtI8m88THr9tHcFs3oiEIo3pWSA5aZjGOMsUoPBTHzcGK2oCIyk8oLXkmeAh79a
         pxJCY1NQpU946OQ8RSWU6i3vrDD5M+ALtnpMmY8Ltx7AWQcRLGOm5fwRTAMDFXN08YsZ
         M5tDcIPl59YIzGEOdSsZF+o53ro3E+RqcjVbdkoB7D7Cq2n7ZxXVLJrXeYtplZbVdUn7
         WExQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPi8lE6NISBSvpMBNvmLKf2+vZI84vlO5ExoLSvnbx2x3KpYExbsU2i3j7POga6Wczrarteog=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+FuQ65UIt08MUzA8W/WNBlWAX47UO8NvQySk4rTMyh0z0p8zd
	t3MlKBPsXY1bRL53gj87GXuHNMwdQwqU3yZQPae3t4QIXAyQWyyz6pQR
X-Gm-Gg: AZuq6aKqDcVwPsTqRrLEcPyyqLzIalLsJbX+q3LzMJVz7ow4HvfnQ66bzZlBbOr+LT7
	uFcDws+ynBsqdwum+l0tGRieMKcLtUINbXZjVahdxwRYvVx/o6wvn/TMmYyT04U3rm1pwxcFdhd
	2DKVwsG2+LOHiUlOe5AqRAAPDTmyAT3O/zLP0MN/O91j9Mmpy1RzOp2yMWMiNE48HVdwM5PE5je
	Udj/+yn+x4lxJsQtZYO2lNfgPDQPaPXe707pbR3eX17hzqosU6TQuhrams4pKb66ghfo4/tyhha
	0xpYiR769N2Nna0d03yObCc1eTEIBHAMbsfL/pWp/dyscLGUbKz8QGoIQDOX0cLCXA2fKgOpvQE
	1oyBOk3qRCwxUhkxYjowW51uvJdSyRbQ8KXbjHNxxnju5iLWCFTPyeXLPGSDsXcJANzJ/swEVYI
	kKlGMxeYh4P2Zf3W3SfA4=
X-Received: by 2002:a17:902:ec92:b0:2a7:bbe0:f01c with SMTP id d9443c01a7336-2a7fe57b403mr51151305ad.17.1769225571900;
        Fri, 23 Jan 2026 19:32:51 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802dcddb0sm32539805ad.38.2026.01.23.19.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 19:32:51 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
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
Subject: [PATCH bpf-next v12 09/13] bpftool: add fsession support
Date: Sat, 24 Jan 2026 11:31:15 +0800
Message-ID: <20260124033119.28682-10-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260124033119.28682-1-dongml2@chinatelecom.cn>
References: <20260124033119.28682-1-dongml2@chinatelecom.cn>
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

