Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792494385;
	b=ca3Z36i2ZAtFqfIQuzwEfmfb3S6vtkh3dZ4o1d4YlH9ONld8ThkHBKm7AUPtscqQEeC7
	 9esR46XWXSJ6ReJNsYP93xEaJboSkWy6JXTmIL7VdRHNWWP5sivjJtP+GWm9E9TxVTYT7
	 0bvwCnlVAUraw0rz2L/XbSoqHOFZg2zUve0VDpOa31HeUJ8fByaYwRwo9beKj3qQFs/29
	 myfbn78l7CkMmDJU+f1GTVIna8vbUwUrOlifJsIMjs2DIxACSOujRgQHLUcChtvMV4Wmr
	 sBgPt8w7cJ1J7rG4zxuD+GtnEwuAEwPAFz0eHAi5z0FUQhNjPRubTTX/75gPq3jG1Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792494385;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=RtJUkqGUT3N4+wugvQQAYYv/c7bO/boq3BJEifDCets=;
	b=bVt9FYCmg+Wnb1GREh8AATBxMCSMEgCTPaoRtOcSO6Z3UiDyBFIN1cx5e2zFovCvdxt7
	 beoFZ25qrpDnmoZwG29bXpRvha0avC7tnTVmvL8FbRwg/HkDkRv2WCoF/T731QmRa5FtI
	 nFkRoCvBmwQVbx1CSk6/asVsstEKBRkZucXDEEbNBVCnKj1r5ZyqMzjz5hPwFNmxqwGrE
	 4FDzODLMJXplt/bGMZP76DPS72IdCjZvwcTut7jeqMe74+q9TlTD3cLrtESkp5y09L2mB
	 Zdq+x5evjjrjAp9S9+t1rR+IAhO2qSZB8WGVhBBCA3w2vbydFw11IvoGGhe6ubAq21Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Akkfj0V2;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8529606A31B
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 11:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8529606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Akkfj0V2
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48b001cd92bso1685832f8f.2
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 04:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792494383; x=1793099183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RtJUkqGUT3N4+wugvQQAYYv/c7bO/boq3BJEifDCets=;
        b=Akkfj0V2koYWmU75E7boNUeaTdwfWqYul4bc0/sYjzJX23iRz8gBnExic0tkxnY0u+
         NDbeDCJ4Qis47tMev4DJlCCBzYbcIodFINhekemO7qmjk6bjulsg5sGL22PDTsytVvKz
         zoINqnVCsnAxtyu+BaBOH58X0slfnvlHkG111dJKyGE6j7hHoqDwLNd6x440C1Mjwsi5
         BGNXMphWw0F6z79HepedwUQ8wpysJTNO42Me7DXSme5rvRI0Ngnq+5SCcl7eZQkrDjZr
         +fcZorzIn64uS8/eSny3cu2LhAg6my9EXJ44VxolHsBGnNXTnfixEf9jBrhvcbU3fz5T
         cf5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792494383; x=1793099183;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RtJUkqGUT3N4+wugvQQAYYv/c7bO/boq3BJEifDCets=;
        b=O78NGtmrgrYvB1YpNizJ985TeZrAAEfLrDNGPtZs7AC5i1vwCzkFaJm4F/YsBl3LYt
         V6FqOyTWiAsZboAdL43DmiFnOLI2Gsr9cXme0h7dHLVitF+S5PzuPP3/CzMHgOZT97EU
         xxfPC9w5qHJqx1ChEfb7ut5b1w6I7oe24pu3tEEx/l+0Zw4k77dx3CaxYe2dOCcihj+5
         r0YPnNEGHWUeYge95jMnHjkxQhIs3xFsx61QKJYeLh+MJoNRSfbfpmaVO/fZzVQMo20L
         JDy9jhWP07rCW5hSFpup42j70KaRT77aPUN8r69guBuI56+KuHZTBVygqsZycX5s4uri
         /oYQ==
X-Forwarded-Encrypted: i=1; AKwUvBwXtTodIZ4EVJDspbumeFDoFN2/OLCLEIi+1jX9r8DpwxJstRLoRF4FSj2aKOgHQcOjpBphPTI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKq/9YZoLmP7BoF3DDG8Aaia5CWsvbfPCmW9cfFptTaTF40gepH
	KwqhvUUxIl/SQ09ZalHHpszXKqzEt1hzqlXb6939q4KXyD5Sebx9HsJd
X-Gm-Gg: AYBFou2Q86OiNtoCG74HxcVFEQvfK1uTd6cQUHpTsYb+M2CR8SAjlXCddPTLPwbYCTM
	9SMTXXJSOKUIFT1I1BuFFxuBxQsbWTvTX6fe4ck0dhVMDlsMOnuzefsdhnzM8JVqpmChzhLrPrB
	+smGYRiw6FH2T9gYhk4aN0daUxLCMFcx5qP0aRfI4ErrIzcsEafc/NH0DLwHpr9eRNwcPklAOGj
	wG4eHcMWly9k9+X7qqr8s5sCfSflW8lYFp2bvawCKX+8Ey4lv/NJ1BpLz+sw38rsfGMombH2Tdp
	MODdWTMgDumAtNV5NSXnVJVO1xDKtyOs8za5VRSxgDsad1qsebm/SpJilJ6tanVm3aCF1Gn8ZuD
	XguzglgfRnG62A3PFppQRMNTGXL1oEOcES/DK/njeCeJCMvzEmijCBiTbgzIEWKYErrmcqF0G75
	Xqp3iz5TC2KkWo0YQ/XpQkwgT9SldQNMptSUeB3QSwoF78E+vnLhtfKBNl0fH7ffsQKQAm3sfWs
	ekM8+Xo7Nid5wNcOR3IjaD9iEs/7TOgTj5j
X-Received: by 2002:adf:e58d:0:b0:48b:118e:7454 with SMTP id ffacd0b85a97d-48e07f9e02bmr15254994f8f.31.1792494383157;
        Tue, 20 Oct 2026 04:06:23 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d8185d2sm5653937f8f.28.2026.10.20.04.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 04:06:22 -0700 (PDT)
Date: Tue, 20 Oct 2026 13:06:20 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, davem@davemloft.net, willemb@google.com,
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com,
	kuba@kernel.org, horms@kernel.org, liamwisehart@meta.com,
	martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org,
	netdev@vger.kernel.org, sdf.kernel@gmail.com,
	yonghong.song@linux.dev, jolsa@kernel.org, kuniyu@google.com,
	memxor@gmail.com, emil@etsalapatis.com, almagui@kernel.org,
	martin.lau@kernel.org, mason@kernel.org, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next 2/8] selftests/bpf: Test allowed bpf_ksock
 operations at send LSM attach
Message-ID: <atdLLO2ubFYmTsw9@gmail.com>
References: <20261020102512.518479-3-mahe.tardy@gmail.com>
 <af7818e22b8336b796a951e86dcb6a63c8ed79e8643e264cfa8ba147e83b594d@mail.kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af7818e22b8336b796a951e86dcb6a63c8ed79e8643e264cfa8ba147e83b594d@mail.kernel.org>

On Tue, Oct 20, 2026 at 10:52:15AM +0000, bot+bpf-ci@kernel.org wrote:
> > selftests/bpf: Test allowed bpf_ksock operations at send LSM attach
> 
> TL;DR: Commit message only: it names ksock_socket_sendmsg(), which isn't a
> real function or hook and is renamed by this patch. Suggest naming the
> socket_sendmsg LSM hook and mentioning the rename.
> 
> >     selftests/bpf: Test allowed bpf_ksock operations at send LSM attach
> >
> >     This test makes sure that bpf_ksock_acquire() and bpf_ksock_release()
> >     can be called from programs attached to ksock_socket_sendmsg().
> >
> >     Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> 
> This isn't a bug, but is ksock_socket_sendmsg() the right name to use here?
> 
> There is no kernel function or LSM hook with that name.  It was the name of
> the existing BPF program in ksock_lsm_verifier.c, and this same patch
> renames that program:
> 
> -int BPF_PROG(ksock_socket_sendmsg, struct socket *sock, struct msghdr *msg,
> +int BPF_PROG(socket_sendmsg_ksock_send, struct socket *sock, struct msghdr *msg,
> 
> so after the patch is applied the identifier in the changelog refers to
> nothing.  The attach point is the socket_sendmsg LSM hook
> (SEC("lsm.s/socket_sendmsg"), i.e. security_socket_sendmsg()).
> 
> Could the changelog name that hook instead, and also mention that the
> existing program is renamed?

Yeah I made that typo in another patch and spotted it before sending but
missed it here, some confusion between the security hook on sendmsg and
the ksock kfunc.

Will fix it in next version.

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39408886865

