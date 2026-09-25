Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE794D9915
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 15:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790351761; cv=none; b=tdBhujV/kQo8YLMlKTJdrtjk9Y+oaiN5NILUw1nJiU9dmBdhDx0bsiVMI9M1zK+HE6e5ZCPXwczLoDnkHvuuuxjpIe1GStQfc0fAbFHvYqaQeomGd0s7egxel4JiRnt1yO3sG4njB10W7klUCmRS3/n9YONWq6Eh9HEKiaMp79Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790351761; c=relaxed/simple;
	bh=1Vgsw4TWmt+frhEKE+d1UUMyDPEGJxohwe6L1tUKy1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmEe5Q4MV5GLToEUp6M1qwlSiLyjqNVzRuMDa1nY20CfnBMKMuOKy7BtFNfSGBQ9d3hlYJxvqPeR3mCX1/k+tkC6iKCr/pBEUJVBtSqSCFwELCtX8OaeogEinW6cBkvnGOsUnN4X4utNBVI/YssQyL9ELqvrEvJXGteIUR9i82o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNYYwM/3; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNYYwM/3"
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2dae660f31bso3290185ad.1
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 08:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790351758; x=1790956558; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wM30FTe9M5c7uFe5K9GQiTlDAZtMBUovZsuoSg4HW48=;
        b=fNYYwM/3b33/1O7JVSZlsmiPEa4TRDaduJ9L0LPdYsx69TRwVz1cF2ilr6u4kZIF7C
         J8yyS+Ts8mIsaNBdMVOyyeNQf5c426tKUKHGeerebcQKFBW/82WkdpChIB4zJVulff5U
         OAqvpZX6RxH+7abQFKfudl6qDOCQPU8TO+CHpj7KKFMU0BUo4xd1+oHfShctWL53fzdo
         U1TWlNmVkgkFLcCGklJYNjW/AhG5kooiuZgtgLBSwgJtXQTJc15oY00DxdqWBKGi7mCA
         QABv7qX3h8WAy2kS4zfcMhrCX5KbwweJCCACNeR/x9nsP/CPsI7+EEse3E6lUhAncJ4Z
         1xCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790351758; x=1790956558;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wM30FTe9M5c7uFe5K9GQiTlDAZtMBUovZsuoSg4HW48=;
        b=HloIyZaHzOPsgfWROp3j5j/RvgCVmBFjU3EneQk8K1m7SHbqnULaI3gOF/zySz2xrR
         kKOvjoUZWCw9IzWOjFRFsk0NTv5G9ePoQpoKGTS+76WAXGSNftd1K8Ypqe6Njc0KEDDG
         tf+CirskStMemtyX1eIwKVLie/hGFJ5MXlz3gKMFvm4lbVMQvUv2SGawyIFJPfWJU+nB
         68u6YCTTT1Fu48+qB1BWOe9eXvthIHn86nuSy1DUWMIrSQuNz+xAbeSjVbYtChhHbyhE
         K5Fk0sQgz+ojx30aoTDRE2RVVn0AWmE+pcxs/qO331GDdBi/W5YD5RXCDtXGh4RBpxhp
         9OJA==
X-Forwarded-Encrypted: i=1; AKwUvBzWA+pR3A6pN/ul28yHoSPEKncjIzcHlD5Tp/KuC7S7J674L10UL77RR6PWjnKf7VvnWGEbmr0=@vger.kernel.org
X-Gm-Message-State: AFuF++lL1vKMF18CKUD/NHzEU9MdQUkhE7XJbYo9B/0H3dVlKDK4xi4V
	ywrDus2y65MV1DBKz7vBhgvGUwM5bcFf9seg1WV7/DL4z3iUNhj29zBs
X-Gm-Gg: AYBFou3si91A/42V/1E0E/RCrghESAG0k0bBt/+2LzrBITu+79q3wF4s/m0Vq+JhtIv
	7zgEFpAhMSC0tc7jD7K6PnXuO2RWdbUHi+4EMFDHpfnpdKnPR0OwKyMATmxpJCa1x7YyQ9fNe0I
	rEEK3hdPGpoXvUAWQSHiYf/sE9isiVX+r2ZYmXwS3CytRqPVw2jYiyhLdTKt5R40yCGgqP00r6m
	vsUuM0dwvIobSyiJKttNRfsGdYj4ObO6sWy8LBk6OAwLaH34pm0xT+6NeCY1D8IEu3M23K1Xx9v
	ds5lfTg/WFqe+PQYGnS/QUjpdJewIjxYZ97GlkKGrJqcNMYq2Hgd/JLGjaymC4ZMjicR1TuJL89
	1wH+dqxxu2ypCTlrVcZuwa+LxZ71Nk3hRVF76v3N7b4lJekBv8S6gxhiuF9/rFWKOOVtegs08ww
	UO7pHHjlOWJibx5w/m0rxd9ZZtwbO1U4xU6Xd1vY+FXdDPdEo7hwPDcZZeQ/3l+yO3
X-Received: by 2002:a17:902:f705:b0:2df:8aea:7d99 with SMTP id d9443c01a7336-2df8aea88aemr34224285ad.59.1790351757623;
        Fri, 25 Sep 2026 08:55:57 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:51::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b4f6345fsm2331050a91.1.2026.09.25.08.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 08:55:57 -0700 (PDT)
Date: Fri, 25 Sep 2026 08:49:20 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, hawk@kernel.org, ilias.apalodimas@linaro.org, axboe@kernel.dk, 
	sdf@fomichev.me, bobbyeshleman@meta.com, kaiyuanz@google.com, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: netmem: add net_iov_area freelist
 helpers
Message-ID: <araXlPI7GjEn9rFK@devvm7509.cco0.facebook.com>
References: <20260922204348.717198-1-sdf@fomichev.me>
 <20260922204348.717198-2-sdf@fomichev.me>
 <CAHS8izPwLBCJXM_0Df8P6S-FVwAq+TaRKn3uTh1h=33Ffj8VmQ@mail.gmail.com>
 <f566591a-cef3-459f-a39e-86addb0c5d7e@gmail.com>
 <arVTvlvKsBRNG2aQ@devvm7509.cco0.facebook.com>
 <8d1c634d-f481-4c10-a773-c4cab414f6c5@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d1c634d-f481-4c10-a773-c4cab414f6c5@gmail.com>

On 09/25, Pavel Begunkov wrote:
> On 9/24/26 17:48, Stanislav Fomichev wrote:
> > On 09/24, Pavel Begunkov wrote:
> > > On 9/24/26 16:02, Mina Almasry wrote:
> > > > On Tue, Sep 22, 2026 at 1:43 PM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
> > > > > 
> > > > > io_uring zero-copy receive and devmem both maintain a bounded LIFO for
> > > > > net_iovs in a contiguous area. Store the freelist in struct net_iov_area
> > > > > and provide common push and pop helpers.
> > > > > 
> > > > > Leave synchronization to area owners. Keep devmem's area adjacent to its
> > > > 
> > > > This could be a follow up change, but I think synchronization should
> > > > be provided by the netmem/niov infra, rather than the area owners. TBH
> > > > the infra providing an unsynchronized data structure and letting the
> > > > area owner use it and shoot themselves in the foot feels error prone.
> > > > For now we could use a comment.
> > > 
> > > I don't think we want it. The duplication is minor, but I'm not set
> > > on the per area index array approach, and it'd make changing it
> > > more difficult.
> > 
> > Do you want me to not touch iou in this patch at all? Or are you talking
> > about potential future synchronization part?
> 
> Sorry, I should've more specific. I meant that I don't think trying to
> consolidate it at all makes much sense, and I'd just drop this patch.
> > I don't see how this is making changing it more difficult, the freelist is
> > now behind push/pop which you can freely change, and both UAPIs benefit
> > from a faster/better freelist.
> 
> There are several reasons. If there is any mismatch in how it's done
> b/w io_uring and devmem it'd need to be split back, and then having it
> in struct net_iov_area for devmem only wouldn't make sense. E.g.
> Packaging of {area/offset} pair if converted to a ifq global list might
> differ. And it moves one part of buffer management to another tree, and
> there was already a precedent of patches being blocked for no technical
> reasons; I'd rather minimise cross-tree changes. Synchronisation might
> also be a bit difficult, zcrx uses it to protect more than just the
> freelist modifications, patterns like lock(zcrx_area->common_area.lock)
> in the zcrx code is usually not a great idea. In general, I just think
> the upside is smaller comparing to losing the development flexibility,
> it's not it makes it faster, nor the current code is tricky or complex.
> Hope it explains it.

SG, none of these sound material to me :-p but I'll resubmit with io_uring
part removed. I do like the index approach (for halving the array memory
requirements), will switch devmem to it.
