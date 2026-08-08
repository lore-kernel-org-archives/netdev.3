Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B36634DCE0
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 06:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786171476; cv=none; b=GTviIy3bQNxTTpUqhMNlQSLK5QxQs0+LXzkw+sHNO72wQYLVgaLuz1DFpHohSY3tzJ+wGhKyUFUXZ29fe2rF9WplJTFlZ0RJNmevhZg9+cQ5IDrGXQ/pk0uGrTegoMhNqU80qU/qKIYrQLJPxqgI9gvE7kw+bidCGhaK5zeqyz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786171476; c=relaxed/simple;
	bh=M/Qp24d7AQPobPqz77kL5+0YRq2C+cjqQ9d92ywDsYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+6s2JtNGoP0g3naWPjHDgLkIywO4Wbhghlgoub62ZQZ84ReiANJ0JSq/GIlyAtC4oFMSX+Qr7EIf2IBvGfnj/42FlWIYZvu7VUGHXs086vQCdaP6eUwvFp7HI0NA2WDrlFOY6kD5DwMa/l4cFjk+Us03OHZZNC4c3E/MM3MzsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhTu/RL2; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhTu/RL2"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso2333585ad.3
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 23:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786171474; x=1786776274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7PHlSYB+1wYgvGMRp4f+WoEwtmY9OUjUGH1XA1YdgyI=;
        b=YhTu/RL2UpkNWL+xFXybxigHn9N8X/3cMQVTXs/uUD5IZ68EA2yxhluN2zJCBgJrf0
         qsfZ3ZL9jEXYnXg1EHyGiBAMEaUlG4ykCwjvhUPRj7ku+Ta8Sf+wSRcndOhp3KoVtxlq
         Taa5ThvEkV5bHzTuHubc1tU4TXUjPvT2TVTXTPwXJjfKC+xTUNd+upt8ahv8xnD+4ufh
         AwJ6de5T5F2KSIH5Diu0KvEfdjGUBcCQdtwc5nJkQJFCOTCCpx6/gOh00yO0U05Nhdn2
         FkOxY3o/xA1tP97eri6pnwkSviuNlunGLa0tW890et6/s/lJCKL7rSkzqr4dh4MsEU1H
         ckCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786171474; x=1786776274;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7PHlSYB+1wYgvGMRp4f+WoEwtmY9OUjUGH1XA1YdgyI=;
        b=DlXiaf2kgeSxeOY/e1XSUGszb4shWRbFFKdf3FJ85EnkdLBkaP7cL0sFxu8nux+7xe
         efNz8za8dKd3xbS3PWCbE7DSEZmzPdzEhXVCHMk2dgUuNIrS4/lRwZILnxg6OWxiXcYk
         UhjDOEThe04B0qbhGA3/qL+25oFCagLT/6UULioGearEl9FTGJarcESmI6AwOE7QS5Zi
         mjjfnC3CYMMaOTP4Ls4zpwMdHKWqw30qsQ4Osn9xFJ1kfSGPbpy2SjsG27/ScXz0SN7I
         ADABW3fZsQWQRDLM/+Q1jfTwbakPASFmAVoNFRmSTzFymHxWakVFB1/HpWktFKdOsJQ0
         fgHA==
X-Gm-Message-State: AOJu0YwKvMGCjHxBfvCDRNnZjLeAPxFErJs1JPRQ16WfRWk2niSY5aqN
	0FUq5sR51jM0Bkw2GOlYm/0tPrHVH6A1km59iceOOuFjLmY8s5T1N6oC
X-Gm-Gg: AR+sD13THcYG5RShAGvnmlByJCabeA5Hy0KzebJdo8vzR5msO6jee1uvODsDQJMcELz
	NLIRwwFeh5O5Fn+cQYnZbxDqCF5ZqSNAtO+D7ipPsRps9p5Xe08iI2KWRnbQyPRw3k9l/OgSxUD
	iir4jhcxBL0EGwF3VX/E61AC83UPHUAMuRO6R1tbMIVcnzR9xBM3DSRZ3/4RjbICxRTJeu0g82f
	u8au1qM7VJUqb/4Ij3p9KO5ByfB+MOp47LKVOtTqvbFLzwWisCjrmbWEM1Et6JVB07adAZG4itW
	516f1n8w/4cAslaVqjQ8QXZth7lnco9aTeqpn+E7XGwGBrmBlGmsUKc001RLsQXcjMRp0yWvwDz
	/y5RBaT/9F3rnWdYu3H3GYrMyXg9doiUHQasXM5MSJ0BIAsCOQQycSPrk4tDD1HWgo5y6rSRQsJ
	qgdZ+cIeBeNFUlEO0QsFIlXXFyn4dZvk2SQijDDgMKjsJLDf0QFKUXlsA=
X-Received: by 2002:a05:6a20:2d13:b0:3c4:396d:4a7f with SMTP id adf61e73a8af0-3cbce7d0551mr6695809637.15.1786171474289;
        Fri, 07 Aug 2026 23:44:34 -0700 (PDT)
Received: from fedora ([203.175.12.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe8f35b3adsm1518804a12.17.2026.08.07.23.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 23:44:33 -0700 (PDT)
Date: Sat, 8 Aug 2026 14:44:23 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Xin Xie <xiexinet@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, andrew+netdev@lunn.ch, shuah@kernel.org,
	kees@kernel.org, petr.wozniak@gmail.com, qingfang.deng@linux.dev,
	fmaurer@redhat.com, luka.gejak@linux.dev, bigeasy@linutronix.de,
	xiaoliang.yang_1@nxp.com, skhawaja@google.com,
	stable@vger.kernel.org, sdf.kernel@gmail.com
Subject: Re: [PATCH net v4 2/4] net: hsr: shrink seqnr_lock to sequence
 counter updates
Message-ID: <anbQR-XiDQ0G4cPo@fedora>
References: <20260803222211.877-1-xiexinet@gmail.com>
 <20260803222211.877-3-xiexinet@gmail.com>
 <anXrR6-2UVYF1iZa@fedora>
 <156d1de2-927f-450c-a809-dff6892d527c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156d1de2-927f-450c-a809-dff6892d527c@gmail.com>

On Fri, Aug 07, 2026 at 04:49:36PM +0200, Xin Xie wrote:
> On 07/08/2026 16:27, Hangbin Liu wrote:
> > 
> > Maybe use a shorter commit description.
> > 
> > Note: Avoid these macros in fast path, prefer per-cpu or per-queue counters.
> > 
> > And the counters in hsr_deliver_master() also need to protected. Especially
> > multicast.
> > 
> > Thanks
> > Hangbin
> 
> Thanks.
> 
> The long commit description was from v4. I reworked and shortened it in v5:
> 
> https://lore.kernel.org/netdev/20260807140751.1351-3-xiexinet@gmail.com/

This length is much shorter. It would be nice to mention Felix's patch, which
is why we can remove the lock from forwarding path now.

And use tag like
    Cc: <stable@vger.kernel.org> # aae9d6b616b5: hsr: Implement more robust duplicate discard for HSR

as Simon suggested.

Maybe also

Reported-by: syzbot+fbf74291c3b7e753b481@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fbf74291c3b7e753b481

> 
> Regarding the statistics, Paolo previously suggested addressing the HSR dev stats races in a separate series, since there are already several occurrences:
> 
> https://lore.kernel.org/netdev/4fc3b9f1-4bef-4b34-ae7a-e89037cce829@redhat.com/
> 
> Would you prefer that I drop the DEV_STATS_* conversions from the next revision and address all HSR statistics consistently in a follow-up, including hsr_deliver_master() and multicast, rather than adding per-CPU accounting to this series?
> 

Makes sense to me. The counter problem should be a separate issue apart
from this one.

Thanks
Hangbin
