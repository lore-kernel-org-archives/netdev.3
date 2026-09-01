Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4633A4734D0
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 08:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252437; cv=none; b=oN2D/8w0dC6V/PW13JQdU+hUCMsowtCTQHh/3vjnqH0ZLjVr65kqghc9wqAiL4bqkfguf9GUA11Lu0pOkmc6C9kMbQQ+MGQM5DgvhTTRLFaJYNxk5PpncZKb7FdoC/swWaS/6es6r7tns6x8dp37p3UFw9j6i32xoITpEbrJ6G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252437; c=relaxed/simple;
	bh=0GGbVa7pGEqnfK1xxfikC0+J0qIxVkU6eehcukiHxOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ArW8ckMaDfa1ZehuUhxYDQu4wiKi1c045pyo5BQOtnYqsO1Ka0qQIvqT4R/geTK1YCLwn84KTotqiNfhX2l2+UVoQapDvJ/uVizRu5rjdwyh+Q2+uDvVi81BkjxlyGOOxj4SfB8rUTh8JM7C4hRGr9wUE/oag45FvyNT6OmN56o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZA9scOos; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cdQJPwbB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZA9scOos";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cdQJPwbB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788252434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yNbo1iN48NrRCyCtQp0s/FOdED9PELoFfdAYNjqH5b8=;
	b=ZA9scOosgA99e+nkhbPNnwYSsgz1+Du6/VbjDIppkE5HGGZxM2/at7mEuTzIF3OWiWBdyi
	FoSvn9zmawdP3SQhE1Kv8TFSIR5WD5k2UNWxsf03veJNrG9Iy44qsnQJFfWqaLBx3wxuap
	OCn87pHwAdLAAe4/uTzYEwD7E2WCg+0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-_zQy2TevMfe2I1ChuYmn3g-1; Tue, 01 Sept 2026 04:47:12 -0400
X-MC-Unique: _zQy2TevMfe2I1ChuYmn3g-1
X-Mimecast-MFC-AGG-ID: _zQy2TevMfe2I1ChuYmn3g_1788252431
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49cced8309bso5036145e9.3
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 01:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788252431; x=1788857231; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yNbo1iN48NrRCyCtQp0s/FOdED9PELoFfdAYNjqH5b8=;
        b=cdQJPwbBTbwn+M1bGKmTdtpr6N8Z+cFo6ydDXIhBMLtqZD11AifXy8wW/t9AjOStun
         /3F05faCMGFJ5Y/pHiQuDlm92hD4XgAtPd5xKgU+ckr7ajYiloESwKA46sUVAeVGQB/n
         y3Nts4+DQOvZFZ9DAUyrrhOAi8MZwKoaiEdTpBx8HMPJKeqMuGLzLVBo2T/pIdGkisUC
         bqb6CwctFHj8avKF4FoqbJXy7q7lR+Nhu4V2XswvcQVBvsDeSU3oiGHsEnMB6b2CeGbL
         P8Q8wkXYlponQsY7us9rClcKPv7IeI/H0D4enSlPG/GtUVFY71GHCjVlLvz+IO8Jzgli
         QjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788252431; x=1788857231;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yNbo1iN48NrRCyCtQp0s/FOdED9PELoFfdAYNjqH5b8=;
        b=IzaAjquGQaaCqV5TmVfThPaNAzyHfy7GG4HcEY7TmcZh0bGDfvLhDm9maLfiAI4a7W
         DczwTmumxzmUreYdisvjfOJmxB9DJS3bPLDwd8V7BEGpU2Crt/LOHR0wxNclvPepg1Uy
         wbHP8TZ45UvI/h/v2VA6OnBItVB6+8XjLtXbJMfVrZ179WRcqjvN/HYJqtmwGUf8FIPW
         G+3YTTody+ssP7frHJk5qDCCcpyYNJrVfivL5aPJzMt9cIpAqpQ3nSZ3wmDe9ARZ/ByB
         upa0aOnPnbMFWWtYSc3Z756bbBnbenN482llR/kAgtw/X3vz3DNGv43UGSQJwdZbnfa0
         JQVw==
X-Forwarded-Encrypted: i=1; AHgh+Rotsp+ZWMAdXt40ieDU5eOaCTrNiKkAXszYdO1V0qKhbYKf3DziweJaFV10vhfAJnODwJAcM8Y=@vger.kernel.org
X-Gm-Message-State: AFuF++lFNQveNsIU8m/dOv39QG7+q9koF6VbR6TxBz6bIMtX47aDz1mz
	t9KKGuXxo8NiNWOnGFV7W76+rbLk72sD1rWREpsDR0OTz9FoHsSwmW7c6pm1cFbUA/ANrOjjvEi
	fG7sbgJmJGmEJebrK9DMSR+CjgaEjy0LL0UeKvy9qu6Y/LKMg/woaK/QNnA==
X-Gm-Gg: AR+sD12nB3heRM0tY3AmjsNvLayC5Lgi4mga5iKAd+qR0ZhGHNN/gTfmkFmG0O6QPkB
	8S32SBkQCNsk66J8X3zr1LCxOnONQf6IxaftgCy8WIg/72gFG4A7oy2Xso2sk2SAfRbAJQLxjpk
	rZJtAo8taFPbBFt3YpdZ8D98nhLeXIH7OhLgjkSx/y05Q/y+yMCH97aMrl9S1FW+bWNYbJ5+HGi
	jiYSRQyB+rxBYiafLEroeDLPH+TVa7V0dZmUtaN6ZSSjbsBWOwlzdlSCmTdQIU4u5J90ZKrAt2X
	qrpbsm5/Ys4m93rfGxAcSpC4/i8bOd9OCxmH1AC+KrTQXEVSkPBt46Pa2L3IWSvI8ZrifGCah+9
	7zWkJhUODgT4EXSnh0YNLTqxl
X-Received: by 2002:a05:600c:4fcb:b0:499:db27:7b1 with SMTP id 5b1f17b1804b1-49b91c62d9bmr482106195e9.15.1788252431331;
        Tue, 01 Sep 2026 01:47:11 -0700 (PDT)
X-Received: by 2002:a05:600c:4fcb:b0:499:db27:7b1 with SMTP id 5b1f17b1804b1-49b91c62d9bmr482105375e9.15.1788252430925;
        Tue, 01 Sep 2026 01:47:10 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce18dbae2sm7383225e9.13.2026.09.01.01.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 01:47:09 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 8E8B297C520; Tue, 01 Sep 2026 10:47:07 +0200 (CEST)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Tue, 01 Sep 2026 10:46:54 +0200
Subject: [PATCH bpf-next v3 1/4] bpftool: Set BPF_F_XDP_DEV_BOUND_ONLY flag
 non-destructively
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260901-libbpf-frags-flags-v3-1-4eb6f14968b0@redhat.com>
References: <20260901-libbpf-frags-flags-v3-0-4eb6f14968b0@redhat.com>
In-Reply-To: <20260901-libbpf-frags-flags-v3-0-4eb6f14968b0@redhat.com>
To: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Larysa Zaremba <larysa.zaremba@intel.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: b4 0.15.2

When setting the XDP hints ifname, bpftool would set the
BPF_F_XDP_DEV_BOUND_ONLY without looking at the existing program flags,
overriding any other flag values. This was always a destructive action,
but after we change libbpf to carry the frags section flag in
prog_flags, this can impact bpftool loading of XDP frags programs.

Change the flag setting to be non-destructive by OR'ing it with the
existing flags.

Fixes: f46392ee3dec ("bpftool: Specify XDP Hints ifname when loading program")
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/bpf/bpftool/prog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index a9f730d407a9..8c2f9255b36d 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1769,7 +1769,7 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
 		}
 
 		if (prog_type == BPF_PROG_TYPE_XDP && xdpmeta_ifindex) {
-			bpf_program__set_flags(pos, BPF_F_XDP_DEV_BOUND_ONLY);
+			bpf_program__set_flags(pos, bpf_program__flags(pos) | BPF_F_XDP_DEV_BOUND_ONLY);
 			bpf_program__set_ifindex(pos, xdpmeta_ifindex);
 		} else {
 			bpf_program__set_ifindex(pos, offload_ifindex);

-- 
2.55.0

