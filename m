Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE4741834D
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 13:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182833; cv=none; b=ZqodQlV6Y9+i62CCGXyS4cBdFfztofLGqaCrbM9lEJlrgp0vC6qzC8Y/n1Usea2TI2RSapXip1lIH2RXxQ03zWF2tbFp1rSHDll+DOohb8v3AaNBI0isPG+EiS01T3X3eIQty3j6CdMHbqnVSsxU11X6Sh3jp3WdpFkwt9lvxuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182833; c=relaxed/simple;
	bh=OIbi3ceGQZ/QjbSWzXjim1yzwnJvjTsZFCloIxWPYhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jIDA8lSZAwVCefRIieFnCn3Ob6TJeSFPTDyQAqPTi0z83nknasBgDGtK9ODZ52+rHXFZCGZvZ93GQVk99JGpf8shsdDNsp7qdfEi+vVV/CveJMvkHFKjIeAr2xgVsxRn4gkp/kQMBfv5dfVZtcrb5bP4Mwjv4+z3he8KTx8Pj7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YWYs4xxF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=F8wZwrTj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YWYs4xxF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="F8wZwrTj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788182830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+KvrdHLkoHirj2epQVtvhrFYMOrEgGC1u8Odq3InD4Y=;
	b=YWYs4xxFiZl4lvjaCo1s2qPYfu2UywyhS7fdJcYTOcrAh30IreZt/oPxWHjnuOXYRXUr54
	8UaAP8ke2RDNj30i4iKeUvDvFuPRDk/fBwX2Cx4XbN5YbFp86ro71jAE1d5MY6XPbi6eOe
	OhdN/xcvdr9RomFBiU/kJ9/nQNbDeiw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-qIKqu4fGPKuxNIdI3fhWJA-1; Mon, 31 Aug 2026 09:27:09 -0400
X-MC-Unique: qIKqu4fGPKuxNIdI3fhWJA-1
X-Mimecast-MFC-AGG-ID: qIKqu4fGPKuxNIdI3fhWJA_1788182828
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48436db95e1so945726f8f.0
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788182828; x=1788787628; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+KvrdHLkoHirj2epQVtvhrFYMOrEgGC1u8Odq3InD4Y=;
        b=F8wZwrTj27r+Mb0/4H6deu6DbomZBPp+TcSOR4ho2WMnN53Egrs99YJ+fAfo9sWx9/
         I0xeqGW2ZKQCeRFpLHdHwqga0jyD9YrenSRfADRKRJbAo4ahy+izdZfxntXFmObrpR7F
         khOl5VP9MTwmhGMNF8UaI8Wv9dfgl/AM8uwz+0OKdRbVlHkW/Cr0CPoyJqeKYXyG2LcD
         mKG9rmEwyOaAOPFpyyS7ka1eOMniRvGneO3NTJuC7c2jDJTN/0QKNCkUvG6zvPfmuH+N
         HcM1qdrQMGmQ+hlVU2rQ/u56DCi7w1WbdiPQA8boW94wtU3dZQJioxTAxT0OeTosoPB/
         6L3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788182828; x=1788787628;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+KvrdHLkoHirj2epQVtvhrFYMOrEgGC1u8Odq3InD4Y=;
        b=dduc7qw9ZUb692Rmk47nOtY36KIzZ1s+1IYh+87AgH3ICW5syrnbfRKT+JJWgL8hCb
         my0ohaCI8bqR4fEP8diaHPdP4FdpEtEjXk0JpqjA4ZE6bkelSemd6ri3zTvmXB5cd7cL
         ig/VIxH7wlmm0XZS/cvfMTNJh1OrMODfzRNpQ7MVBvJoXLL269yyzO0rvBs1ZAiY51V0
         Qpy5tWV9moiqdUNAkzdHoLCEAGf6SvF0IcEAZkTaFws0edy/mhdwaJjPfU7B+7Kymhq4
         3Yuxl1bnRvWw9SKMY6X+ixKCopi7kW/A09X3/3Ky9Np0ZCTTWmLDKbaaJ/phu3kQODru
         jYcw==
X-Forwarded-Encrypted: i=1; AKwUvBym46zRVZg24mtoYg4J6mgFrBmeMSEViGiCEubcgtzaUY+XnQsWwFt4IGwCDDny+Wx+Nybnlss=@vger.kernel.org
X-Gm-Message-State: AFuF++mm/MW0Qwm1cpyTPvG85gS1SE7v9KAtE+EX56JYcZpD2rKPcwhB
	IjgsXiInbVbF0p1s9tU+lDRbfrp2opI7w0Qakz3WJN40G4vwLT5M/3FBj+OcneX590KTHcRYPaT
	/Q5Y9/Nsyf2QFVa0sjGZ6nHEfOLvveQ/4GkfRTU35YKTAZA5Z1JUVvpM+Zw==
X-Gm-Gg: AYBFou3ld2IZol8/6uxbS90xbUmt6rK4QpKh+Olox/Q+bJA5aeEk8+sraY/YTN2ZUps
	YWEzRl1b2aJyuzq5rTPSr7i2sgd0lTcINGSaZXlVF5bvk+PXtKUZPCZT2cqfBuzLoD7E6IVIIEy
	PhO6sa3fYTd5aa0ZDv+I3Rjm3lL1+/q3nDjPgAbAiHjzM5KxveGLBwf0PbMYeNyQfzK5EOcAvQ8
	Dgg0BS3+qcw7MW7K+mQ7mYVqamaXG+hBW0xny2FWmC3qMFBjk46fgb9YkRDoMx0MdbkYL5kT60N
	fqjbQRYK5qHsaG6W8pr4GsgsoMmWIY8uee0lDhs0EUD7tWQNIQD+1/7zKJPch+JGV5PP5OpXH1p
	Slb8V6BPMaKNquhK+ru0HSG+P
X-Received: by 2002:a05:6000:2288:b0:47f:e377:8d61 with SMTP id ffacd0b85a97d-482f79c9511mr39217374f8f.11.1788182827935;
        Mon, 31 Aug 2026 06:27:07 -0700 (PDT)
X-Received: by 2002:a05:6000:2288:b0:47f:e377:8d61 with SMTP id ffacd0b85a97d-482f79c9511mr39217230f8f.11.1788182827310;
        Mon, 31 Aug 2026 06:27:07 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb32d30sm23633940f8f.34.2026.08.31.06.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 06:27:06 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 385CF97C44E; Mon, 31 Aug 2026 15:27:06 +0200 (CEST)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v2 2/4] bpf: selftests: Check for flag presence in bpf_program__flags()
Date: Mon, 31 Aug 2026 15:26:42 +0200
Message-ID: <20260831132648.65843-2-toke@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831132648.65843-1-toke@redhat.com>
References: <20260831132648.65843-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a check that the BPF_F_XDP_HAS_FRAGS and BPF_F_SLEEPABLE flags show
up in bpf_program__flags() when opening a BPF program with the flag
definitions in their section definitions.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/bpf/prog_tests/kernel_flag.c       | 3 +++
 tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c  | 3 +++
 tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c | 5 +++++
 3 files changed, 11 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/kernel_flag.c b/tools/testing/selftests/bpf/prog_tests/kernel_flag.c
index 97b00c7efe94..25eb59f460ab 100644
--- a/tools/testing/selftests/bpf/prog_tests/kernel_flag.c
+++ b/tools/testing/selftests/bpf/prog_tests/kernel_flag.c
@@ -16,6 +16,9 @@ void test_kernel_flag(void)
 	if (!ASSERT_OK_PTR(lsm_skel, "lsm_skel"))
 		return;
 
+	ASSERT_EQ(bpf_program__flags(lsm_skel->progs.bpf) & BPF_F_SLEEPABLE,
+		  BPF_F_SLEEPABLE, "sleepable in program flags");
+
 	lsm_skel->bss->monitored_tid = sys_gettid();
 
 	ret = test_kernel_flag__attach(lsm_skel);
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c
index fce203640f8c..a894b1ab46f4 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c
@@ -18,6 +18,9 @@ static void test_xdp_update_frags(void)
 		return;
 
 	prog = bpf_object__next_program(obj, NULL);
+	ASSERT_EQ(bpf_program__flags(prog) & BPF_F_XDP_HAS_FRAGS,
+		  BPF_F_XDP_HAS_FRAGS, "frags in program flags");
+
 	if (bpf_object__load(obj))
 		return;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
index a8ab05216c38..dff6b3e7266e 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
@@ -146,6 +146,11 @@ static void test_xdp_with_devmap_frags_helpers(void)
 	if (!ASSERT_OK_PTR(skel, "test_xdp_with_devmap_helpers__open_and_load"))
 		return;
 
+	ASSERT_EQ(bpf_program__flags(skel->progs.xdp_dummy_dm_frags) & BPF_F_XDP_HAS_FRAGS,
+		  BPF_F_XDP_HAS_FRAGS, "frags in program flags");
+	ASSERT_EQ(bpf_program__flags(skel->progs.xdp_dummy_dm) & BPF_F_XDP_HAS_FRAGS,
+		  0, "frags not in program flags");
+
 	dm_fd_frags = bpf_program__fd(skel->progs.xdp_dummy_dm_frags);
 	map_fd = bpf_map__fd(skel->maps.dm_ports);
 	err = bpf_prog_get_info_by_fd(dm_fd_frags, &info, &len);
-- 
2.55.0

