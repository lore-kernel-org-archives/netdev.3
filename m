Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793763857;
	b=CjW3K4JZGAFn/0vsm6JSPGgzsOC8po7+oYxXmARFRQADlM9MBe8sJQ6/CgoOneg4Sexs
	 zCy+JPwt7f2h9jAu516wWiuF+Bn9GeQkZu6QnZmSlbNGg1i6FKYlMBetNamLO/0iSFWqw
	 sCSeFpR5Fg8W/Vff0NVF1r8McMbnTBMfD15vCAL2N96I49VWb8tq1yZ3oRd4i+FtQwRqW
	 tkhHRTRV0tDMieb4UFDb7WUW0Ns1NnEc5Qaif9Ty/QssSuiKhMVsjZRfeQ49t4sJW+2vw
	 LTg+5P2GnPXIOL15//dfjuB/B+UpJmqSPik6HJVSxplMrD1zbvqixOIBr1K95idrUNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793763857;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4AbJL+GJHDouH42I2kH1rN6GVH0vPYGzrGpyLYdLBcE=;
	b=0XvaiOXdzIRCqmYccHDupW2HTeFmWeRgdaiegZ81PaGOCwoGO0IPghn7P/CIrD/le3vC
	 WKb6+eHeuiqPjmtjz+3SBt0fEXzqYa78tn1zz0uewlpQLcUOxNYIDx6CFRfF6yvpaYbp4
	 oRIaodiback7JRmbAHkazDJabZBc7R+tCUQkE3BdFbuc7r77JoPdkR1af7nZsNt8ywUHO
	 O7Dm2m2sYo84g457Fb5oKoJT87Ne03Xedd0w0/cxHcpcrZJXxAiW/jD0Jt5CU//V21NhR
	 oXkPDrr0IffcmHEzvHpcC+vazMnuDSl4gfC0Dct9gsg5F3fg8PYrk1DRaCHaAoUZ4KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="IoUgnSG/";
	arc=none smtp.remote-ip=74.125.231.138
Received: from mail-oo2-f10.google.com (mail-oo2-f10.google.com [74.125.231.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6D4606A326
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 03:44:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA6D4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IoUgnSG/
Received: by mail-oo2-f10.google.com with SMTP id 006d021491bc7-6f9b24c99b6so80266eaf.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 19:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793763855; x=1794368655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4AbJL+GJHDouH42I2kH1rN6GVH0vPYGzrGpyLYdLBcE=;
        b=IoUgnSG/1IXtQck6ePr/QnEL9a1/ILXobXrtHcErpAqPAx0ko6ZyeR1zGhsmEy9EEY
         I2AUIec50/7DpfKWLhaK9xXcGJFgp8zb+EaBl5/gvQzaecaqg4PK7//1x/WbI4WKSTlG
         l83DjVGIcG5s5yrQsH7gwJnBOPddSDzfkch9RCrAsqwHvUHGGEhErpt7VmYfMdv5icRI
         5PK39lxW2S5aCUmV4b2Uy14fmiHrbxnNCadXG1elU/qtwXq5UIxVTL8BU1C6Pfa0QcbN
         2eR1WB0LJAlQLNLYCTPDyYJgRnshlRRRdkQIvzJiRMrmHgIY/e/rTSoY84ssytW6CL8I
         6uqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793763855; x=1794368655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4AbJL+GJHDouH42I2kH1rN6GVH0vPYGzrGpyLYdLBcE=;
        b=eWNpeDEqjhKZHEUhKiXzhyVnzFTjKqQgJyzLieLcgcUqdemiBldJxXgwBMdXzttfTM
         XTjdtN08P7Hz1F7FIqm62VKfVedH+qBWv0cHpxRieuxGpXTWTwZmil24kxaoNQWbPxPN
         zAwVexcvmdR1InNq4lVJZI0tMlyU9tZYJ8vVGUuoAJxR41uyeZN9buimvQ4yd5huBp+p
         uqnpoZYdPUPGFiepmvE565ZcVCqUqLJtzhS3mtoI9s/G5LKDYLvYDIQGShzesx66Ukid
         +cHhZE/k38BbffDmM3Xhw33aKq2ajC+HcQ9h1IDfXZNfTmNuj+NVh27+bnfsJ4cXWYp/
         9pDg==
X-Gm-Message-State: APuU4Z9QemlDKdqVsEn0NpHEMSkEXHLqBhGV2XT8jI/Pdl9c+xhRAgde
	R+syoLaTVQa+OEVb9Q3iK08lmjrLyh0fBFNE9rKodCVGOkVGS1D0B5gDdp1p9dMw1enr3g==
X-Gm-Gg: AYBFou2zXIB4ksO+QuJwLIEh93looHrmCqiQY1O+lEZhaDnkV1wYyYul4zBBFbLMtub
	wEOFkyLMNdO/lhuovuvQ81Dx6peWSUzGgJ2Gx1pUntVZaeVeMD4gO9fKXw53OA71/MukT77Zclv
	LSrw1MyGCCYxu8otJxOLXYvgjtPaLpabRdGnvQ9BWQAAfJJF+WEdoT7Vw/Ol1JHD1J93OykPtum
	QHNw/cfnKsKJ/2W5w5UFGTbnqR11jpIk7GhVisKq5PQkd0S1my1PALHfdK6Hj5uqTNYJwctBuc+
	cQDtLRBpcmSe7FH9qNIz1DO+poA0Lw4t57BVy+1UIoI9QFa2J0Wsg/Dw98DIs6LHteSEsLAg5e+
	+Ih3NxYIGhQsGYla90d5AcSQGcGl3QW4mV9w3UWlcGC3uJumuY5WiHHKOwNziBHPdyG0onF6ujG
	+Z32bqkiA0rKBv7Q+GW4ddmb1MSbWSjrDgmz/nnM7V3Hcp6s7ScGj1mXBV4jZ76PAjXfzxFAR4P
	UIOcf4WEZhdBLQCaj2V5xz/AmI4KNQgGZNOtenPBy/7IpX2EZ5d8Gj4dFv27KFuNauBmJDM/uDA
	KoM6lITZda139xWtR5/vKSElsoS6oTromMEN9LIdkYYr20aDCtDhzZrmuMbec3P/rPAW
X-Received: by 2002:a05:6871:2b17:b0:494:895e:c3e2 with SMTP id 586e51a60fabf-4a90764ca88mr10001468fac.20.1793763855511;
        Tue, 03 Nov 2026 19:44:15 -0800 (PST)
Received: from localhost.localdomain ([14.116.239.38])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4acea61d382sm838651fac.13.2026.11.03.19.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 19:44:14 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: netdev@vger.kernel.org
Cc: julius@bairaktaris.de,
	dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	steffen.klassert@secunet.com,
	willemb@google.com,
	jiayuan.chen@linux.dev,
	mfleming@cloudflare.com,
	almasrymina@google.com,
	bigeasy@linutronix.de,
	richardbgobert@gmail.com,
	ecree.xilinx@gmail.com,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: Re: [PATCH net v4 1/4] net: make room for the tunnel header in skb_segment_list()
Date: Wed,  4 Nov 2026 11:42:38 +0800
Message-ID: <20261104034238.676662-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <b27640960edcb8e072fdd2e8d282c1deee747b8a.1792838740.git.julius@bairaktaris.de>
References: <b27640960edcb8e072fdd2e8d282c1deee747b8a.1792838740.git.julius@bairaktaris.de>
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

Tested this on v7.4-rc1 (6628e7d4c6b2, KASAN build) with an
independent reproducer (vxlan, fraglist GRO merged segments with
2-byte headroom, software tunnel GSO):

- unpatched: KASAN slab-use-after-free write of size 2 in
  skb_udp_tunnel_segment+0x1360, then skb_under_panic
  len:-64444 put:-65522, panic;
- with this patch: 149 GSO frames over 150 s, all ~4.8k
  segments correctly forwarded, zero KASAN reports, no panic,
  system stays up.

Tested-by: Henry Martin <bsdhenrymartin@gmail.com>
