Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA402EEE90
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 05:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228156; cv=none; b=GFz3ynhdsnx7mLjB3JBuy7pXYlZdcLAQmrzY+U0QK6Br8CGIX1eTw/AdWpQea9mvsChCC5+QuwDkzopEFMNY+U2E8TZIUVvKcWfBD6pc5dF7MPGDmXH+ISWr3mO1ZTupSvjfoJr79pnXLPV3EkEHNyPzarL2pmbtK8VwqimAcBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228156; c=relaxed/simple;
	bh=S7YCobBC+HtmpFNk+7TFsgHmGtIoWTkcQMy5z7Dbx1w=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=L3s4MG6iyl2jOylSTkl72N0jkiYjpBs7rO9K2NsVGZpdXxMkL01TYODgvHRQvWteM2Pj0ztRzmgPeZf9IZgdw7FvKcFrY1Z6rRnAjYUdCTM7vmqHDNRyIyRgH24AypDlOpFGNamGUSjH2unHndU31gpCa9MC0yygzjntJ5iDiGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ON6pdYdQ; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ON6pdYdQ"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85f0fc1fd8eso848500b3a.1
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 22:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790228154; x=1790832954; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZgV+zt06A+GVhiZtJGM9pKXkNiudT+kcv0q8qPUw5Lk=;
        b=ON6pdYdQqqkchV/gy0fNyvMY/t3qbVvF2RCoGW60etofLkHLVcI/fvv44FqDq2csJI
         gT4nQpxv6Y0EQB7ieG7ozL4vfxlogTG+5dOTIrzRukhaCTP8Dsn75Z1wIAhcroDhrO9G
         M4Y/5f6g0QS8M5i8vk0zbPz+STp9EH2D3IMQNgu+J7svAkvV2yYjcqxl8MLHCetwsB45
         dh7ZuqNYalTYdLPXaVo/MGxpwLUoqJ/Mv51BCpHTj+lP9igMj0XviNQLOndxBg1JT3ss
         9AjLf0L892WOrJ6+8foJLelB59CnTxI01cPP9s/k+y6SiG4AnsmI+DMOlzXCmFbQ+7Le
         SJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790228154; x=1790832954;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZgV+zt06A+GVhiZtJGM9pKXkNiudT+kcv0q8qPUw5Lk=;
        b=I33iI9ouD2pHN1IE6l3QSUMqOR90F5PYUoWDVmKTWlxdtIW3vC/v4/qzaR7Z/LJ+um
         ijglUgIOjb1b1PtwLyMJADy4t8YLeT519c+6eb5aFWW/TLBWY/FvyqyBGuGpf2sPfZmB
         HQ0OrjwBAjWmMfTJaftPG1W4+eKVtIGwRJ7Z36tQq0QjivuoXnuxEdHafk0VhxU0Ec+y
         m4IRI+YmkCqhyvo1hdJ+28JUuXZkskp+yUbBQnhYCTUd994onhThLRQ/221PFwa7opFq
         b0RDoOhvBgmNC/OTEnoaxN3YkN28NqljyTn44baUA1HAgASau5dE2eZmO6ofeYltw9jz
         UwTw==
X-Forwarded-Encrypted: i=1; AKwUvBwkD4ZOSpnSkLtfw7Om4SCWOeanAM747AWAIDpwZcqSkiDZ1aRf0f12qtBcdHXFpStVmnBzROw=@vger.kernel.org
X-Gm-Message-State: AFuF++llI/0YA7BWeoJPzeWTjkYXJS0svAmIFxD5mik4ynlh/kq1Ju82
	n9PI1OamVqFR3spjamZ0bIpB0q4a4hfFxQW79bBQCcZA3GJQU47A0OvZ
X-Gm-Gg: AYBFou1RXgOPDG93F3fxxp5j8dXDG1a/lyNmxbovtTYwkVfPxbj1eW2zFnEBFfiZdI4
	pgFtrEZQpLwiDD3lOdsjK69blA0jcv/pbv1O5osjOp9zDunGjGnEPTFFd0mNfY8WTpkbtm7SGiF
	C1c1zKr3MhIJH/FLZLmzezcIQzAIFnH/OaiIbiNb8eg6JD4eeIYirRCeS4q6CgNZTeHFkYR3OsK
	fZkyJVm47fJVh1Jp9eyISN8zORCF9/13T0M43uWJRlPI464eDutC233F3lSWxoBtKn1vDnrm6jw
	ee7abs3fatSuORO4QGgdkrnuDKxBEW0G6+elcNM7JXuqCM0WDHDW4hwqjhAJn7JMQ3dOWMEbf7d
	qUF+7k/X4mLSs7WLnoQrpxnzsdjAz+HN3pqb204CmyH0/VCki0tcJZ+S9NbRZ+f79SdeQlv5BBh
	AyNuVutCRfpIscbph4C5Wv+DG39oZHwFkZbMYw183snMeSdUd543Tig5TxYtiNoXFeM+gVc0m5s
	ebPM3LdrKEV84z6XEkoLiY0B6s8FxDxaE8+5z3cabQnUyBsn8PGLmzBneOLOF7/CSUhFFzEV+ru
	2aI=
X-Received: by 2002:a05:6a00:330c:b0:86b:43f6:67c3 with SMTP id d2e1a72fcca58-87e99087d5cmr1123543b3a.18.1790228153413;
        Wed, 23 Sep 2026 22:35:53 -0700 (PDT)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1d5bfc87sm2268080b3a.25.2026.09.23.22.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 22:35:53 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 05:35:52 +0000
Message-Id: <DLNAWZH4J2VL.35H5TXY9SPLM8@gmail.com>
Cc: "Hui Zhu" <zhuhui@kylinos.cn>
Subject: Re: [PATCH bpf-next 2/2] samples/bpf: Add memcg async reclaim
 example
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Hui Zhu" <hui.zhu@linux.dev>, "Roman Gushchin"
 <roman.gushchin@linux.dev>, "JP Kobryn" <inwardvessel@gmail.com>, "Shakeel
 Butt" <shakeel.butt@linux.dev>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Ihor Solodrai" <ihor.solodrai@linux.dev>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan"
 <shuah@kernel.org>, "David Hildenbrand" <david@kernel.org>, "Barry Song"
 <baohua@kernel.org>, "Geliang Tang" <geliang@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>,
 "Stanislav Fomichev" <sdf@fomichev.me>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>
In-Reply-To: <de7adb6bafa3b808e29c0630f7ed9a2003e5e447.1790222105.git.zhuhui@kylinos.cn>
References: <cover.1790222105.git.zhuhui@kylinos.cn> <de7adb6bafa3b808e29c0630f7ed9a2003e5e447.1790222105.git.zhuhui@kylinos.cn>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Sep 24, 2026 at 12:04 PM Hui Zhu <hui.zhu@linux.dev> wrote:
> Add an example of BPF-driven async proactive reclaim, keeping the
> complex monitoring scenario out of the selftests. A BPF program arms a
> bpf_wq/timer chain that watches the workingset refaults (file and anon)
> of a monitor cgroup; when they grow past a threshold, a round of
> bpf_proactive_reclaim() batches reclaims a target cgroup, re-arming the
> work queue until the round budget is spent.
[...]
>  samples/bpf/memcg_async_reclaim.bpf.c  |  349 ++++++++
>  samples/bpf/memcg_async_reclaim.h      |   39 +
>  samples/bpf/memcg_async_reclaim_user.c | 1141 ++++++++++++++++++++++++
>  5 files changed, 1539 insertions(+), 1 deletion(-)

No. We're not adding new samples to samples/bpf.
1200 lines were overkill as a selftest. 1500 lines as a sample
are not better.
samples/bpf/ are dead. We do not add new things there.

pw-bot: cr
