Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB9123EA97
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 05:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786945677; cv=none; b=cBw+jgSBFzmq1Pimp/mNyT2y2legckj69mPC9WWGAZsyIFFui8fe+HoSiKESpRIarQgpA7olBGN6ljqLKpEzuPTZinD1GG/e/5dgken5cPndu6tAR+MmPza2HlrH1lr+ho8JxQpszjVUpIvmKl5mkCIo8MqopfW4DY4oGsT1FhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786945677; c=relaxed/simple;
	bh=t5LkuqMqSBDUZFm7n4ylTFEfSwfBfetqZglPH04zBGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M18M3QEHgu9FM++bqwpZKjsmznxHeKNlq0wUkYXffVy3+7bZBg4ZefUCmsL3q1zhaypUB/PFkBvEJn0D8HDffYcAyGQ9ILH6z4y72UpZyEMVaWGkm/za3O0HI7sM3uvXjx5Xc22mqAagF1ERkunzsxJcDZ2xdyvEhjzXIZMI4fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FltPG2+q; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FltPG2+q"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3900e39d935so2733792a91.0
        for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 22:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786945675; x=1787550475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dOqn6TSsjS3exGWTr9VD38ncbtn4FsSPim4nM//Vhaw=;
        b=FltPG2+qNuGHUqxYz/D3NwPv22P4IifrK2PmfPunM/AJCm2diLYx/r1Lrx68V5b3g1
         U263t/0V/emMJN8sZZoZWqtcH7OmNaT1nVp1JzuOUmQEnnT5f0SLUBYGISGWLpRXQx8k
         V3uNKvWp4tKeKB3HRfmDDJYu/UvPjqZ4JXkkFI6A+PViE2k+UrXawJUmwvKVkocEQDQP
         P3SLqIKrW5rNSpcxBays97xvs+owQE1/nfr+szKFHEQcuJrkOJupZ8ktJsm96rsqaUPc
         65PLhyJPR7f6WBf+iL3aKXw/jPhd7kdVC6WEktJoK/b/LUYc6DRjbMuCljqedhaLxFlR
         QF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786945675; x=1787550475;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dOqn6TSsjS3exGWTr9VD38ncbtn4FsSPim4nM//Vhaw=;
        b=jCIf7n0TCe1Co5GSruWZ1dPOuh6Pikp90dpfD3GNLxQq2BlrhHbH8/BE2t0a5xRUbt
         NW3u7W1yoqBqxZFbZLTa1B/Z6zaEJ1RrvQsW79j+nvYKImbBNSRrQljVhgBsV7jEx8Fb
         M6PtIz4tIoKq8kcwC87jCSeQgEX/LbZg2cuFUy/NqNNs/tCW8Ao7CuBSKQoE+RhBGpY7
         J57z9X/wnRylQfDe9yj6eCkOQQ/BnRO0z3jjNOt8p2mguJAO9dkSCW6KGkhRwnC8CLZM
         2rCjCIDhcrZKnwKYNejj4udIhdPsNITuPHnr8AnLvZvWOht7D8Bo/960ndamZWniUrHt
         vC5g==
X-Forwarded-Encrypted: i=1; AHgh+RpcON522+AERF5snHBpGLUFKgUYoBfxWKv7N38iHJ1vEPqenejbRLCRH3bS2ZbH7D32dMUNJsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtfdaZmV8vxZJ1kkygTDThwkp9EdyERHQfsUBsG7SssXnLljc7
	nvg8pOpnKA2spcjqJKGmid8UfYaauE/5Zjw9+QVGntbxny0WTKDwjebB
X-Gm-Gg: AR+sD10GveOXxhdIF7XGCmKHEczOhjSQeaRN4tGHXYozz18FQTerUtiDiybbR7PGp7y
	GD6Eokb7dKT7vsBTXRHJuEM0Gr8bwXaO/C91OlMuHQiWXHFYdsokqiOSJ1mVTFZIYSEtG5KhjTk
	EiuXizZVPZZP4R+Nb9+/C+ftPmLkR4hcxyj0R4VVo9ixjsgtS73nohbaU0pnkaSydDxp38283b+
	OdXNjbrfveLjRR9q/4lP1TJQC06v0XCB3qMj+BEWcH1S9A0phvVim0yBhyJsAfb9ad/D5WE+b3d
	F+T/uPjzB7YjlYtOn5rD4GtdK3jBFnf7h5f4Mf5i8KE37CeCND42cwiUr+MSnP1nIdJriWgK9CL
	45HUPfkCjgV+JR6oLj7zJrgv3lVEPjTS3FquELV2T0f07iLGTCvjIbTFIEFehTE6ol8lsK9i6tV
	OY3Ygeb4n2xmwto5mIZEPi5ZSq6MHPSDubIousoRdtq5O/hMwqyRvA31qTIyFL3kJyIFEw
X-Received: by 2002:a17:90b:5707:b0:38f:5801:dc0e with SMTP id 98e67ed59e1d1-3933e61bee2mr24461071a91.15.1786945675256;
        Sun, 16 Aug 2026 22:47:55 -0700 (PDT)
Received: from fedora ([216.236.36.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531e31b8fsm3441703a91.3.2026.08.16.22.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 22:47:54 -0700 (PDT)
Date: Mon, 17 Aug 2026 13:47:48 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Raczynski <j.raczynski@samsung.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH net-next 2/2] docs: netdev: clarify expected interactions
 with LLMs
Message-ID: <aoKghLx9K6PvZkht@fedora>
References: <cover.1784884817.git.pabeni@redhat.com>
 <83360de7addb13a3b5f4d5e722148f248fdb2ae0.1784884817.git.pabeni@redhat.com>
 <CGME20260724115642eucas1p29f9c8bdc59a889ad66cb7b2a52cdaef7@eucas1p2.samsung.com>
 <amNS9/owsgr44v7w@AMDC4622.eu.corp.samsungelectronics.net>
 <68b50e02-c238-48c6-b2aa-98eb21077329@kernel.org>
 <an8OY1XeDr1ajATf@fedora>
 <20260814120750.420d75d1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814120750.420d75d1@kernel.org>

On Fri, Aug 14, 2026 at 12:07:50PM -0700, Jakub Kicinski wrote:
> On Fri, 14 Aug 2026 20:47:31 +0800 Hangbin Liu wrote:
> > I think the ideal way is for the result to be subscribed to. 
> 
> It'd be ideal if y'all run the LLMs locally before sending the patches..
> I understand that it's not always possible, but let's be clear on what
> the priorities are - as you say netdev@ is already too busy, we don't
> want the buggy submissions in the first place, _ideally_.

I would follow this rule, although my LLM provider is not smart enough...

Thanks
Hangbin
