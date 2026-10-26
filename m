Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793032236;
	b=L/eGKA4MHEjDZdSRwKycqVylXW56Gy66NpC7UrVXWNkbJJy3J43S2jXleRpsJndOAWyy
	 1ksTjdQ33fFqu0WUG9tUdAavcI8F6FJktpmUBKf7XYw+T+yjDhVMgbAuILyzob7qkV78b
	 KiZYPoehN6szDGkqY7GhCMbjVIc92IitVu0iuop94m0900uZaYxbY0eYY9SxvAFSs8OtN
	 NdgbTvULawI5+FH8wHXnjHAc4DhUQGxC5lC8KAxiiCDr73FRQIYReaZJno2bSslUpL4T7
	 mFkxTKJpejk7lQ6C+1ZcDwgEKJ9hhSGMDSQfWSnP5Nh9fBoT+xdqY+1bgjTJD75VTqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793032236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WGd8hv6dQ0jpXHntVrEKsl2n+adOY8jZkAHXTXnqh7c=;
	b=t6gbD1KHEjqNF9QFGqnjeaOqmwz/Tmlr/Jejj+7tSay5/CqpZTYON17wqFygxiWR8RDL
	 lv6fqvsRMkMSEhP9x+AFHD9O4kSDXHMl5tAKkKIxKwi4R1yi8+JbMr74HcIkTMKat9qBa
	 U6DRv36NRQE6phV55+GDCyGcGulpqyS+n5VPoYpozkFDcLHd0ASP4H4cGKy3ssLFPK/Eg
	 qCsJ8J/R40iR7IRFaonJug6PUkMlazzgxeXNKQ07jz+sNKsfnRQzZZFvy7He65aq5Yhzb
	 0tVfftqdbPleRC8mvDu6G+HO0KBjATaWIIAUE8LuD4CwCaPTIUDZH2YgGHJoZNgXKrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OWgrT87Q;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21232606AA32
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 16:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21232606AA32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OWgrT87Q
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-35c76e9614aso5146629eec.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 09:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793032234; x=1793637034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WGd8hv6dQ0jpXHntVrEKsl2n+adOY8jZkAHXTXnqh7c=;
        b=OWgrT87Qj/2zyW8smzZBl773SMPrPIzcvxCXye5uBT8QFVCCjI9Rok0yb22yySWm7Z
         XxKPx1VpKgrJr1Z9ev71PvTb8vFPBIiAiIBfFBPkCyV5KkbZiZfxLW1hrjRMlIoXXzQv
         Pi2jcEap2puXyNfA+70UuljWtojYba002F5ZqLUETRQBGKklcmM2NkLVq+uvOYvQxHH1
         FK25Og2Kk078DLTMCVWxJcKUk6lVI7qlVD3UJcaeKOEYhOscCtsRqlWx2eRPix3JrhTR
         m7vjPzGwMMuwHNDEd+a41fikRJO53eLxA5tTjkQJBnY2A1xWp+M5V7bzqk69179sGXSa
         gXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793032234; x=1793637034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WGd8hv6dQ0jpXHntVrEKsl2n+adOY8jZkAHXTXnqh7c=;
        b=tUyj5l+nYq4Gx1afFBQFdbZOOz1LfD+3MjNnlHQvC/opMFxJ52rD+4jfcvmMaMVgcr
         Tbe6kWvIJHJKul7HjK0toH/SVsz1N4T2qYp+lQbKNLFlczoLH2aFXWfW20zKv0CBkRTL
         0pMlqjIwzXBZMcp/zRfm5eifW7PlnHR4+yUSJ4iWiA2b2mVcTZ1hIbgXC2TJTr8iaWg4
         mAyB7jjDl/kDRt7h3YL1OZE9PysxD662Usx/wTav/9v7M1M0X7rbKD2u40LLuHBO0Iy0
         dhdMXXUJotwAfA3eVcSoH0cZ/mg7FTI3uh1qNsUX/A1eRFaAm9mmSX6XK8w4v7m2Hbu6
         Xe+w==
X-Forwarded-Encrypted: i=1; AKwUvBwzIMFixY7QXhfzV1u64cxD5eOKW1WVcEdyxzAMMPWzx/rIcIKMnvVlnUK9O63wjWH9n/ytLiw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJmniRPizbuMKJNuoG/MZZqDGVcj5FSl1+Vof2CVlyNqs0P4QN8
	wGrfu9Nln+Au1aFQkXD8xoFT5Z2l+yRlMpBQADgF52X8RM1wQCqFbQqz
X-Gm-Gg: AYBFou3+eObj3bTeyY7PWYA+d3R33kB7KnNZ7KW8IAk03d57R08baJX/jrhDjyWtejL
	K64jAv+4SjqoXezEcvrj0EB6bneVK/ZIj6j5xN+ENo0OkTRp/XSELHxUuyQKOqaVImYrlKXbxzO
	pU86CKYXPqLAwTuEaBFMGxYZ7D6f3X2NJrznc7zz08+DczCvz4Xaip39Omk0KdZlR9H6kYxBwzn
	4FESqvs6UdD+ftzh/IkAD6gS3yMXMTTjVDWGr2eJBO4bVTlPcXataXDg13J7Q1aFOFzR041zeyw
	rVZ5sNyAc7anKv7C11bcrBU5LIond7/dofqk0DZiKW1+BMbjBJ4jzztt5+Y9JK17GQSH2IY8jb4
	wk1Bw32TOldo3hIY6Bwar4tdE06bDuefZRBQq+4Jqwj+CTuCDucT6uiB4KnuGx6LxVYG9hdakXy
	y+in7vwP0T1VAhB3wlKTHXDAbYUvIQXeg/reIavUSyGFApGDvpPXncYJxihpQnOTs2Lv1vLQscz
	9HO0NIbSZ3zmx/KR3MRUaJMgOYNs6ixCPQjZKeerWFOosRfYiuVy+nTor1iGXmcnjxlGLIwmsKc
	mFqC2+CdYysqg4eDxw7gFEqUnn3OORoR2gtm9CqYE/ASHmsD7j9AfkPaDZhpP2trk2XoW7IUvaE
	=
X-Received: by 2002:a05:7301:1530:b0:35e:da0a:75b0 with SMTP id 5a478bee46e88-369e84e94a7mr11024368eec.25.1793032233734;
        Mon, 26 Oct 2026 09:30:33 -0700 (PDT)
Received: from nixos ([2405:201:c40d:9039:f859:3f74:c064:3281])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8db7b23sm36119014eec.19.2026.10.26.09.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:30:32 -0700 (PDT)
From: Ayushman Rout <ayushmanrout27@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	Ayushman Rout <ayushmanrout27@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf v2 2/2] selftests/bpf: Test overlapping dynptr copies on xdp frags
Date: Mon, 26 Oct 2026 21:58:09 +0530
Message-ID: <20261026162810.12862-3-ayushmanrout27@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261026162810.12862-1-ayushmanrout27@gmail.com>
References: <20261026162810.12862-1-ayushmanrout27@gmail.com>
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

Add dynptr tests for copies within one xdp packet with frags, where the
source and the destination overlap and the destination is above the
source:

- test_dynptr_copy_xdp_overlap: both ranges cross from the linear part
  into frag0. bpf_dynptr_copy() of 1200 bytes with the destination 100
  bytes above the source.
- test_dynptr_copy_xdp_overlap_src_linear: the source is in the linear
  part and the destination crosses into frag0.
- test_dynptr_copy_xdp_overlap_dst_frag: the source crosses into frag0
  and the destination is in frag0.

The new tests set err when the data is wrong. The existing
test_dynptr_copy_xdp does not, so it can pass on corrupted data.

Without the fix to bpf_dynptr_copy(), test_dynptr_copy_xdp_overlap
fails. With it, all the new tests pass.

Signed-off-by: Ayushman Rout <ayushmanrout27@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/dynptr.c |  3 +
 .../selftests/bpf/progs/dynptr_success.c      | 90 +++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
index 4396560365e8..cbb2cc9969be 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -22,6 +22,9 @@ static struct {
 	{"test_dynptr_data", SETUP_SYSCALL_SLEEP},
 	{"test_dynptr_copy", SETUP_SYSCALL_SLEEP},
 	{"test_dynptr_copy_xdp", SETUP_XDP_PROG},
+	{"test_dynptr_copy_xdp_overlap", SETUP_XDP_PROG},
+	{"test_dynptr_copy_xdp_overlap_src_linear", SETUP_XDP_PROG},
+	{"test_dynptr_copy_xdp_overlap_dst_frag", SETUP_XDP_PROG},
 	{"test_dynptr_memset_zero", SETUP_SYSCALL_SLEEP},
 	{"test_dynptr_memset_notzero", SETUP_SYSCALL_SLEEP},
 	{"test_dynptr_memset_zero_offset", SETUP_SYSCALL_SLEEP},
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
index b668ebd61fc7..56be4eafc270 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -759,6 +759,96 @@ int test_dynptr_copy_xdp(struct xdp_md *xdp)
 	return XDP_DROP;
 }
 
+static __always_inline int fill_xdp(struct bpf_dynptr *ptr, __u32 start, __u32 n)
+{
+	__u8 b;
+	int i;
+
+	bpf_for(i, 0, n) {
+		b = (start + i) % 251;
+		if (bpf_dynptr_write(ptr, start + i, &b, 1, 0))
+			return 1;
+	}
+	return 0;
+}
+
+static __always_inline int check_xdp(struct bpf_dynptr *ptr, __u32 at, __u32 n, __u32 from)
+{
+	__u8 b;
+	int i;
+
+	bpf_for(i, 0, n) {
+		if (bpf_dynptr_read(&b, 1, ptr, at + i, 0))
+			return 1;
+		if (b != (__u8)((from + i) % 251))
+			return 1;
+	}
+	return 0;
+}
+
+SEC("?xdp")
+int test_dynptr_copy_xdp_overlap(struct xdp_md *xdp)
+{
+	void *data_end = (void *)(long)xdp->data_end;
+	void *data = (void *)(long)xdp->data;
+	__u32 off = data_end - data - 1000;
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_from_xdp(xdp, 0, &ptr);
+	if (fill_xdp(&ptr, off, 1300)) {
+		err = 1;
+		return XDP_DROP;
+	}
+	err = bpf_dynptr_copy(&ptr, off + 100, &ptr, off, 1200);
+	if (err)
+		return XDP_DROP;
+	if (check_xdp(&ptr, off + 100, 1200, off))
+		err = 2;
+	return XDP_DROP;
+}
+
+SEC("?xdp")
+int test_dynptr_copy_xdp_overlap_src_linear(struct xdp_md *xdp)
+{
+	void *data_end = (void *)(long)xdp->data_end;
+	void *data = (void *)(long)xdp->data;
+	__u32 lin = data_end - data;
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_from_xdp(xdp, 0, &ptr);
+	if (fill_xdp(&ptr, lin - 64, 118)) {
+		err = 1;
+		return XDP_DROP;
+	}
+	err = bpf_dynptr_copy(&ptr, lin - 10, &ptr, lin - 64, 64);
+	if (err)
+		return XDP_DROP;
+	if (check_xdp(&ptr, lin - 10, 64, lin - 64))
+		err = 2;
+	return XDP_DROP;
+}
+
+SEC("?xdp")
+int test_dynptr_copy_xdp_overlap_dst_frag(struct xdp_md *xdp)
+{
+	void *data_end = (void *)(long)xdp->data_end;
+	void *data = (void *)(long)xdp->data;
+	__u32 lin = data_end - data;
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_from_xdp(xdp, 0, &ptr);
+	if (fill_xdp(&ptr, lin - 10, 84)) {
+		err = 1;
+		return XDP_DROP;
+	}
+	err = bpf_dynptr_copy(&ptr, lin + 10, &ptr, lin - 10, 64);
+	if (err)
+		return XDP_DROP;
+	if (check_xdp(&ptr, lin + 10, 64, lin - 10))
+		err = 2;
+	return XDP_DROP;
+}
+
 char memset_zero_data[] = "data to be zeroed";
 
 SEC("?tp/syscalls/sys_enter_nanosleep")
-- 
2.54.0

