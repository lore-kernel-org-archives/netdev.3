Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5A6576ED4
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790097635; cv=none; b=s8SsiHNrWnMmVAs5KTmrnecV9++ICUksPrpTcX4eqi8KiIlHmWjGliYekaNlRrFbh6cl4MaqUfwMNTU8E0Lr2z2xM84pqcKqi4jN8bci3hhfHg+z1TcONoHu8eD579RIkGER2R33KSPGICTVh+oajLA/P/vai37IFXjAaMoYkU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790097635; c=relaxed/simple;
	bh=EctU5tIWtB2qjqn1ZLRB7qyQZKQFVQkM/uMviUC6kBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a5oVGYV239Cw+l78CiQUAOCPqbCDhLXfTmv4ljpIVyvH/0cJnF6NtXJVRDl5TNO4awmRyU/q61LD2KhfPtzZ85m4SNrO0ftjahPlRTD2cmfzKCdR37l3PIjv7BgTQvQoPrB44FHlVgC9Qlwzhej+b+BnoXc5YATMYBqeGXZq4xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Vj93JdUF; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Vj93JdUF"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4c08393b0so161390a12.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 10:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790097633; x=1790702433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ox2RZ0k+DkbRVW04kS8F4kKfbRT+U8FtjRI8GPPnTMk=;
        b=Vj93JdUFj5Z8TrHJ6YL8sz3TYpIlPwW8ZixT1CKg6sEYBBYwNkvvnGZla0RsYcla7q
         zv93/vHwk49wgN+KndhyuY+xPfh/UIBh0RgkBlRlCR7BZ5EdNi2nafH2S3ycMe4k1wo3
         R4mUb57sOZwR4iiOHjO8FRvbkJzvdv1i1Gs37jctqLlINI6GDGgTl98higO8wAzcdLYZ
         NlHARfV/hxdkCSVywWVJSE+cicVGKF7KlBNduKRzqneMdKYYHNT1t6Iga036J/oH4rTO
         oad+LSAe+5XPelDPM2G8to9okb5GoUnlu9kYa0Geewm6RSyFK7RQdruImX46a45CoyQe
         p7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790097633; x=1790702433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ox2RZ0k+DkbRVW04kS8F4kKfbRT+U8FtjRI8GPPnTMk=;
        b=tswPvAWIkH1o8oan76WiUCq4sVP+7vFU8EyvrLeZjqJmOpnNfHsxGMfvkLoN3PGqb0
         C2RJCHcUSyhqapFVuSHhlOT0yIE/4IgmX2THgEOaiwu0C4sevDffovXnH92MV8kIaAgy
         5I6b4aIiepq0mXfv4zp/SdEgDU9GYGnkfa/WKmAne6wle3DN/0gJ37nIzjBLzPTgTWGs
         0HJb/iCvDmb2MJ8XotgigEC9Vz8dRaq6cSQYc1ii/inRxUEG17d/0Wbs1P2FuTyKHn46
         oFDkOTXfuPQJ3++YCfgUfVkdHiYQaWGuFew+tylDOxx23OjUeejvu2oF8FSOrKuP2p75
         cR3g==
X-Forwarded-Encrypted: i=1; AKwUvByXoH7we80yQGvBrotTd691IGaocqOxSD2ucbEihfwAQ2cbuv3ZDruNwKGg1U4/ZW13mXM9H+k=@vger.kernel.org
X-Gm-Message-State: AFuF++lInfvViZkRhtuvzcO5G0qWW7B3WXVtJOzwPImR4R67NJvMZi5P
	eDc+mjE5/n7BKc6iQsTHTa7Xo/54C4u+VtMF3FPv9PbpLJJr6goxRIZRMWGtJaTGw/Y=
X-Gm-Gg: AYBFou0xEl/qWT2R791dHhMCev9xLZRg37v7RbBYnKXNNqo4YB3FD2YIQSLCx45/3bb
	iuYR5xV6OVtrAsAAnp3dydfCCq/Obp4eKCH45p6b85vfKnEL+z/m6UK55wWiBBAmjz5B3O4JPj6
	O3NtbwPDeIr+e1x+nDHYodFCpGcUJ+2+ptpuE75sg4wVEICePVjkCPWi2oWbPpzcVB2LKyOJOdY
	PGtuSn9nxU0l0N9ZH7x/NkJKzhYIL8nM0tsNRb3g6OWmchv5cKy2cbhxHfuxsyLfCnitt5ZyqZu
	XA7dNUsJLew095/qfdm/1crQdHFcQvlnU0vD2PkVw/YXI1tg8/mM6C4+chvOmG+lnVCfCM9ibxh
	lN4m7QK8lD4La025qFHLdiTsHKdOYtSZ2DPuXMvy3WEh6phhSl93whWbktRwTE9SobgAhQhUGxp
	1zi5FUdcX3Si9ntzRhVr/npgx0DrLlZLevVDur5NfC51J8wWSxnGyvSkZLyIgo2sU5y9bJCxaZu
	BU+bamvt1n2YR1fp54smlBMBB32Q5otvNVxVFt5zQ==
X-Received: by 2002:a17:90b:3e4b:b0:39e:6c69:34d4 with SMTP id 98e67ed59e1d1-3a07e793f0dmr98798a91.56.1790097632838;
        Tue, 22 Sep 2026 10:20:32 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06cb7159fsm1774824a91.4.2026.09.22.10.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 10:20:32 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <nicholas@carlini.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: [PATCH bpf v2 01/11] bpf: Fix bounds check for skb-backed dynptrs
Date: Tue, 22 Sep 2026 17:20:18 +0000
Message-ID: <20260922172028.6269-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260922172028.6269-1-emil@etsalapatis.com>
References: <20260922172028.6269-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The skb_pointer_if_linear() function checks whether a
memory region of length len starting at offset off into
the skb is in the linear area, and returns a pointer to
the region if so. The check currently subtracts between
skb_headlen and offset of the check, and since skb_headlen
is unsigned the subtraction can underflow. This causes the
bounds check to spuriously pass and generate an arbitrary
pointer of the form *(skb->data + off).

The only user of this helper is currently skb-backed BPF
dynptr code. Returning the wrong pointer leads to the
dynptr erroneously being backed with invalid memory.

Ensure the subtraction cannot underflow, and fail the check if
it would. Use u64 arithmetic to also prevent overflow when
calculating (skb_headlen(skb) - off) since off is unsigned.

Fixes: 6f5a630d7c57 ("bpf, net: Introduce skb_pointer_if_linear().")
Reported-by: Nicholas Carlini <nicholas@carlini.com>
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 include/linux/skbuff.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 421f6fc45..c8e219030 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4372,7 +4372,10 @@ skb_header_pointer_careful(const struct sk_buff *skb, int offset,
 static inline void * __must_check
 skb_pointer_if_linear(const struct sk_buff *skb, int offset, int len)
 {
-	if (likely(skb_headlen(skb) - offset >= len))
+	unsigned int uoffset = (unsigned int)offset;
+
+	if (likely(uoffset <= skb_headlen(skb) &&
+		   (unsigned int)len <= skb_headlen(skb) - uoffset))
 		return skb->data + offset;
 	return NULL;
 }
-- 
2.54.0

