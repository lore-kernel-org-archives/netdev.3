Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415458;
	b=tJ5T0jXCR0WX77NS4D159Se7fFnI5MFUuyi1q6Orbb97MyvGxuNmAzhHqHOZsjaex3CB
	 +5Kjp+ZbHOCry1nixvtwtQGYCBefdBkZhAmR2o/DdtOYsMuI6JJxNNDOZXj/+cvEPEaJw
	 u2Bo72xXB9P2ZYQh1r7yzIIao2+4qmoJisRLRnTch2lAis1VtqFKZPZX1ZqPcbGwbD80M
	 TdDCeA6jY0LYMOQgRoCLOAbp7qrqR3haizNGn3O6SvWZueLxW0tc2hXQwLOhNzHnPjDKJ
	 Fbds/zqP+LAlgzlS10t6FUSEfwk+UEoR6SDX1EWg0D2Q2CPqFknDO7pP/Lbgfv9P+Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415458;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=eZsD1auAFGH9focpKeQLt7lmstuziSR0maGDEOD7IaE=;
	b=udiZcRQiKqs5UMaCtD41hDUjqZL0Y8InaUTldz0183DbZRPmJgQ7Qn0p86ms8ivZl1A0
	 Bz7PMB7EL34bINN8JrA9xrExlsepWj/a50cJWWl2pZWS5o/q0KBCa/mOQuA3RrXmp9PZV
	 4npBlOEoPx/k9aZ25PwKhYcWSbgTEOX9WhCvrsJHWWVtrcw/D5F26iigCq3fE9epsKNPm
	 vYm7gYskKlL/DWX+2OA+P1jZNPVW3QltAbNmulg/wXTwf1DjWVkfWKz05BR1sYnDmuGPh
	 pSptMgRzYFAquo8hNgorJiPiB0cW1pxukIVIW2YUyLHjKbrS3/2xGlgoh6Q6yt5Pphw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=RlnO6Plk;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD449606A334
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 16:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD449606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=RlnO6Plk
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cdd89d84521so3712a12.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 08:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794415457; x=1795020257; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eZsD1auAFGH9focpKeQLt7lmstuziSR0maGDEOD7IaE=;
        b=RlnO6Plk7dvbSysvOB/ID3k5DcKiC4/56cqtP22XDbI+b+yOaZOevB/mi0166VHoDE
         nmMdxqiq9SvORfklvVLg1CJ1UEOt0M7T2bJTudVoPMjMS/yR+3MSHVBRu+FwIAW/VJsb
         PKaE3E/tj648mENds/a775P4W8FGyNt0it5aE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415457; x=1795020257;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eZsD1auAFGH9focpKeQLt7lmstuziSR0maGDEOD7IaE=;
        b=vb66j3ZVvOE0NYOs0eK7Lgbbn4DdA19OpZDlz3REB3NgyZW3kdaoASdM2Nhel169j/
         UbjwKrV5org08LLtfL+22lrmIfB0YCfkECR2aBCg+CJU9XaCOlCkV0wZCGRV4j6/S3h3
         yVZlIluzftpD/C3J28ulbNlEp78ho8tKES/4aHMvkkInbe/t8Mvrh0IQiqVBasKNWn3F
         cpK+fEEXwu2zYhEGWxLMt4n8iPRuu1sy9Xm27vulSSWldxZl70LoUtjMZ6iPhu3pISOC
         p8YBKzMQI7ySiXh4rNvNhJY5qbzdimd0VIIG1cwkw3CPy0WoaakJ5mnrDZ+AVry+ZG+a
         GFdw==
X-Forwarded-Encrypted: i=1; AL+hErGq4dI39UCBQQlmZIMRnibR8mo/D7n6e2xwMwdkyYBpjYXaLrQ7rSOuNs+UY33SXGrpDSMdRfc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+6twNonJkCNddtCPiXF1QxAx1fkiK9kz6ZMs3QYpmQd4wWCEJ2
	ju2dPFco/8Jbl0cCdGy3l0d3H3FLm19QExMT61Fa3hnFj26XvC3aLnNfFnYAcenqVeUA3cbsrmI
	Vwa//E8XiFQ==
X-Gm-Gg: AYBFou1IPkv1ln19FDV2S4RdclGrsenyTOaYbvgJ8u4tUGQsKge0DbVHprJYUgZSvto
	cqdREwGX+foKPe5unFmfUPx86L7Cf0rRCZT76ok+vuwSP9+qe48tJC49eHwc85rTCERQIi8Ky0L
	8xv6weYWQA1ZyMgv1cGLM/IkazVW8TGjxHqROGtEILYrvs8bJ367XTT7kZatDOGho+XEaOYwMrB
	s9iYQSrWR22XIci8oKmJtGqD28RJlpk15jl8HxRmocpT+1b+lic65dZVZArdOogvwmymmGJUrMO
	5xANwu7fbyFaEi9rJ/GpgXtX5GFGdhDMKMrUAbqOr2VWpGd8JEU+TF5SylBcGtmbSAMKRSYXj9x
	Eff2SXEss6M32mLIiIRZSkO4Ks+3OTpL+Vft9uJDT+Hia2CO9w/Tgulkdq8eX0QliVIdVqjrknx
	6wrBkXT/HKq9MyKeFmY8K0juwAM9gRB01zd+Fq1bcJuBN55R4jTcaqPvH4gRRZhhQzHL2ygClmR
	Xaf47qYTgXRLHiTCl51CAg3Lnus7ydMdInYChiQeP+1jHztwunHo0bT2NkxnwIH227TPqh0M5Zg
	m778X1V9kW1E/ULlVsdSdkL/W7DpMniiSBYUcnwE7d+5a1WqoLptnWDfaIzuW0YfAAVijxECUsD
	Ni9k=
X-Received: by 2002:a17:90b:4c47:b0:3b0:a413:dd8e with SMTP id 98e67ed59e1d1-3b197cdd7cbmr13614a91.43.1794415457111;
        Wed, 11 Nov 2026 08:44:17 -0800 (PST)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com. [209.85.216.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b181bc799csm2316175a91.0.2026.11.11.08.44.16
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 08:44:16 -0800 (PST)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ae6b4c669fso16065a91.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 08:44:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFiu/x/QGXKiAi2VEmXq1LSE5ikmEALOh9zh0Y+9km87qre/PYwdtbGo0q/cjglYk17t3Ltx88=@vger.kernel.org
X-Received: by 2002:a17:90b:1d45:b0:3a0:cca0:4a8c with SMTP id
 98e67ed59e1d1-3b197c817dbmr35589a91.7.1794415456305; Wed, 11 Nov 2026
 08:44:16 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110145241.536019-1-kas@kernel.org> <20261110145241.536019-2-kas@kernel.org>
 <avNuQqLf9CG9dSsE@casper.infradead.org> <20261111-heimreisen-ungeziefer-empfunden-a892571f2c07@brauner>
 <20261111-thunfisch-wirbt-waldrand-822275b2d3b1@brauner>
In-Reply-To: <20261111-thunfisch-wirbt-waldrand-822275b2d3b1@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 11 Nov 2026 08:43:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjPY=kfgnmtx4COEQjD5UzKx9m2-=KLGAZP4d=RKEH+pg@mail.gmail.com>
X-Gm-Features: AclHuK9b6hltBFcCGqxpbtG8UmrJwldogvwXrVDW7-YQ5_XK3IWVlpv59flts7k
Message-ID: <CAHk-=wjPY=kfgnmtx4COEQjD5UzKx9m2-=KLGAZP4d=RKEH+pg@mail.gmail.com>
Subject: Re: [PATCH 1/4] virtio_console: copy pipe buffers in splice_write()
To: Christian Brauner <brauner@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, "Kiryl Shutsemau (Meta)" <kas@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, Amit Shah <amit@kernel.org>, 
	Jan Kara <jack@suse.cz>, "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Bernd Schubert <bschubert@ddn.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Nov 2026 at 05:42, Christian Brauner <brauner@kernel.org> wrote:
>
> So the fix below is what we've done before for pipes and I think it's
> the right thing to do here too. I put the following on vfs.fixes:

Please no.

> -       src = kmap_local_page(buf->page);
> -       memcpy(page_address(page) + offset, src + buf->offset, len);
> -       kunmap_local(src);

This boils down to one memcpy.

HIGHMEM is dead. Nobody sane uses it. It *will* go away. It's already
effectively never ever used.

There are some broken 32-bit arm setups that use it, and legacy museum
32-bit x86.

Don't make one memcpy() that can be inlined become this garbage:

> +       /* The buffer can span several pages of a compound page. */
> +       kv.iov_base = page_address(page) + offset;
> +       kv.iov_len = len;
> +       iov_iter_kvec(&to, ITER_DEST, &kv, 1, len);
> +       if (copy_page_to_iter(buf->page, buf->offset, len, &to) != len) {
> +               __free_page(page);
> +               return -EFAULT;
> +       }

just because of broken shit that nobody has ever complained about or ever hit.

              Linus
