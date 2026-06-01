Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8C1377561
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 12:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780315510; cv=none; b=kwZc41W+oq8QXyTpxDvq3kJarGBgtotJWr+R8tanSSuobaKCeGglKYHmF9o+0CklhNFh7pAfaNN2EmG1kDvo/njmjLmoeG1AMxHE5zJsGkG+8IHxRDwF75KlfhW8Zq0fG9Gp7Sdd69lZgPnGpORPMqMngUVuZVEdLKaU0S7Wiqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780315510; c=relaxed/simple;
	bh=DVPrzP17YUC2/4Q8TVocnAfB26OhfA7HKz6X7OLh/G8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s7YL4rr4JyuJaN0pE5kHYb+pP5TQYyFTIgzpua7EtAYCQuRlzSDz9bx8U8g210vJ0jZoRm+Aau14VblZ2cgMWgULHx0/a9wgn1mwBa9JXefsMP5GiNkBLEuqmaea+iaB5reWsh5VosHWhqgZBknklunIGJU9t/d5QlsKqrP/WEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYvMGZ7I; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYvMGZ7I"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45fd461e4a5so1219958f8f.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 05:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780315507; x=1780920307; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w+QgZSYAIQbT1ounnPkdiL3vC6WFojP4CBfbK3LRjyY=;
        b=CYvMGZ7IVgo8b2n2veePC/gPBQ0KWVmbE/tW8wt7epO4nfctaAsYGHC5PTQcdONGky
         0/aKXaUOjlqa7+wzqt2sDO1iHzWk3qaJe2rs6DRZgGnWwpGebiJMHSfzxLEwE/5wOZKg
         bYlSSUKG3IjFzF9jmNzJTFCpIJ0ftaBJbB71jH9wi9I1GGXSqkSWMCNyLCuyCVR/qWop
         KSpbSAVWHZFrWG9yzJMEloNf2Zgg/Tgaf8/Ywsi66cRlxtOndSf/UUxHXylRm4hTOyvv
         QjxmiDnaT6o62Qs4j5sl0DdTsBGuAoqanr0bBvTITge6G/DFYz5ZAZPC5pUHeg3sX+X3
         GJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780315507; x=1780920307;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+QgZSYAIQbT1ounnPkdiL3vC6WFojP4CBfbK3LRjyY=;
        b=QOUO608XzQZ67nvtSrSn6OsAmU6vlcbvmqrXMvjdR7quQXSIhOenDMU5bbzx9y1YP7
         F+Jbzoo8v8vIia6Ntmo0vl6CW/QYQmRY58asO1mtrceiEyYawvmMjG6F2BZh1W6m6h87
         Bez7bQSb6ztplLqyFM/H+9b6rGvYVN3oACTG4wprQdCdXZqOnYomzxBQvOkDpy1NTR5Y
         +YUItnq0ePZl7oWN6/LqxRik9MxzeWQtiZcyxJddxhs+6Of2lOudPhGhuAc0enY0YJJU
         FPjAc3e0r/FkzGLGD3Jh5iKJPh+G4GTgGuIhtlHiQWhZzIDd7xUNbyeZp2vic6fg9hab
         9iEQ==
X-Gm-Message-State: AOJu0Ywv6bprXLO6IoYiZLXUXc+0Wkfsj2wuQHzNLCT5/o9lNLEYuQhv
	g6AMsLH/JpainW/37BKJP8FDCKreRsB7qtEq4+TpvoWYEN8lUdo61Z6U
X-Gm-Gg: Acq92OHWG1O4zB40NYQM8oUEXqBEO+QzRIV63z2l21jX6IU54SG02jVq1Cy9RHxSvci
	vVGmuQ3P0S9fEnGJbBPhx2/CEq3Y1s6MOlrX4sRayB//gRDwDhka1ckgqMrnxuiGpLymJhqhbgF
	DX/nLwrfFMzrX3Ws/omRhQBu//zy3iXMYTzS6U+xx+hy1gIxBCqBOZX+rqrElS9uNGOseM8gspJ
	ZTgb+hUoNpTyEFzD/41sZ9iBQ8D0zLYAgHg4uopW7YB6qaLVn7okqNoQkbFAg8dDXtstbeN2m0o
	HYqYG8psmZNtigBWgBu6rSyrHW2aFRi2M+0fax2wZVoc8QGJjrvc3jNDDtXpExtRJSDkEJIagrt
	kZbTC6oMiBb4LNaPz4BkXmZIHhZIbtSU6Dfwq+RhL/Mxopyn9qxA9zs9lDW3oO42CL1kJgCMNG1
	RNWTjQCk1WaUgdgjoWimNgnnqKjaVB8x5L7u7sU8ldMqUDpGwPUX4AMzlw+147LJ94Yl8DZwlW5
	7ggDdncga93O2gZKWNsuA==
X-Received: by 2002:adf:f481:0:b0:45e:e513:f451 with SMTP id ffacd0b85a97d-45ef6b0300bmr14395037f8f.7.1780315506890;
        Mon, 01 Jun 2026 05:05:06 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34b7d6bsm26195159f8f.10.2026.06.01.05.05.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 05:05:06 -0700 (PDT)
Message-ID: <29eaa2d6-784b-4a12-acb3-099052ba0933@gmail.com>
Date: Mon, 1 Jun 2026 13:05:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 12/13] selftests/bpf: Test using file dynptr
 after the reference on file is dropped
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@kernel.org, kernel-team@meta.com
References: <20260529014936.2811085-1-ameryhung@gmail.com>
 <20260529014936.2811085-13-ameryhung@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260529014936.2811085-13-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/29/26 2:49 AM, Amery Hung wrote:
> File dynptr and slice should be invalidated when the parent file's
> reference is dropped in the program. Without the verifier tracking
> dyntpr's parent referenced object, the dynptr would continute to be
> incorrectly used even if the underlying file is being tear down or gone.
> 
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  .../selftests/bpf/progs/file_reader_fail.c    | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/progs/file_reader_fail.c b/tools/testing/selftests/bpf/progs/file_reader_fail.c
> index 0739620dea8a..d5fae5e4cf9a 100644
> --- a/tools/testing/selftests/bpf/progs/file_reader_fail.c
> +++ b/tools/testing/selftests/bpf/progs/file_reader_fail.c
> @@ -50,3 +50,63 @@ int xdp_no_dynptr_type(struct xdp_md *xdp)
>  	bpf_dynptr_file_discard(&dynptr);
>  	return 0;
>  }
> +
> +SEC("lsm/file_open")
> +__failure
> +__msg("Leaking reference id={{[0-9]+}} alloc_insn={{[0-9]+}}. Release it first.")
> +int use_file_dynptr_after_put_file(void *ctx)
> +{
> +	struct task_struct *task = bpf_get_current_task_btf();
> +	struct file *file = bpf_get_task_exe_file(task);
> +	struct bpf_dynptr dynptr;
> +	char buf[64];
> +
> +	if (!file)
> +		return 0;
> +
> +	if (bpf_dynptr_from_file(file, 0, &dynptr))
> +		goto out;
> +
> +	/* this should fail - file dynptr should be discarded first to prevent resource leak */
> +	bpf_put_file(file);
> +
> +	bpf_dynptr_read(buf, sizeof(buf), &dynptr, 0, 0);
> +	return 0;
> +
> +out:
> +	bpf_dynptr_file_discard(&dynptr);
> +	bpf_put_file(file);
> +	return 0;
> +}
> +
> +SEC("lsm/file_open")
> +__failure
> +__msg("Leaking reference id={{[0-9]+}} alloc_insn={{[0-9]+}}. Release it first.")
> +int use_file_dynptr_slice_after_put_file(void *ctx)
> +{
> +	struct task_struct *task = bpf_get_current_task_btf();
> +	struct file *file = bpf_get_task_exe_file(task);
> +	struct bpf_dynptr dynptr;
> +	char *data;
> +
> +	if (!file)
> +		return 0;
> +
> +	if (bpf_dynptr_from_file(file, 0, &dynptr))
> +		goto out;
> +
> +	data = bpf_dynptr_data(&dynptr, 0, 1);

File dynptr is always read-only, so bpf_dynptr_data() always
returns NULL. Verifier does not know this (not sure if we should
address it). Maybe it makes sense to remove this call or substitute by
probe read, just to avoid confusing example.

> +	if (!data)
> +		goto out;
> +
> +	/* this should fail - file dynptr should be discarded first to prevent resource leak */
> +	bpf_put_file(file);
> +
> +	*data = 'x';
> +	return 0;
> +
> +out:
> +	bpf_dynptr_file_discard(&dynptr);
> +	bpf_put_file(file);
> +	return 0;
> +}

