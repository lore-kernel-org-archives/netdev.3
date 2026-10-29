Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793258534;
	b=lcXKbKZ2WJJljzaoq9PPnGOJli4fZHNpEanUzl+Moz+aT6kMlDgVvS1xX5h/WcxmuKqz
	 lKk8yjC/DA/a3kjEPSfx5SJDW88Ev8BVkWg3hqOcMlNfeQBZ11mhMgQlUSoXuVhaStWzG
	 rub4SSp61L7urDqmt8wtsEa335XNeJ1obXHOJmdH5zuk9FPCxZgjGShtayx5qxpnLPL4T
	 onvlcVeF7JalMn53ZiyNEi/6oyKA4BXg7OsyzamlfvGWyBegjumhQePTEIGPsQuqMomGN
	 AIz34eoW2wiXdG1n+wkmrIUzFAl1aa9JZMa1MSGkRbTKj+rInhD+DhwjtqX0LhsbipQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793258534;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=TsAQS4rA4H1iNqLsq84hKblFTfrWhP+kWPfdX+CCGew=;
	b=y3kyn08fOC55zxr7CrZe7m5A9XhiyN7TddidLUol65W6esFXrz03xFYSjdNvo3Ze2pYb
	 apDy8TRVCcNGb2yW9sr7neeJiAkBLDw6RN8kRajLorbmYw6JGGjfaGe6AK0z2FgEE2rWO
	 kNbBpkIMY6djGYbfF2Kmwfek+bFed0XFhcm9EzZgpgNV32YxAKL4OENDXkS2uK+Jf8kmj
	 pg5i0ASuQWAdkWjiQLWEeaH7HSuuWIe7IcYqmtheOUQfEOjJzahAB/90X3NypRH0IJS39
	 2Ddt0Scw2rzTPdorWBmTY/PjWbNdZBsB3xtuVFSX8QvzC/m5oxTbLQR3fX2o38lZF5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h3nLwMmr;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=bkhC7wkX;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690A5606A31D
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 07:22:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 690A5606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h3nLwMmr;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=bkhC7wkX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793258532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TsAQS4rA4H1iNqLsq84hKblFTfrWhP+kWPfdX+CCGew=;
	b=h3nLwMmrpaKBunfv6J9qj8Mygc+YphlZjqN7N7KR8jR0YGYdb3HGDiZdNYh9KOJ/4qmddq
	RRNQQyJR+L9z3P45u+ls8clcYTthLAPRBQzbL+S0FtIEyCj7Zyo93OrTURPponA7VvqLks
	C/t6yGNVc4bqVyjv10uFS1YdSs5O7l4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-n5kQNq84Nw-VVIa7oZj6mQ-1; Thu, 29 Oct 2026 03:22:10 -0400
X-MC-Unique: n5kQNq84Nw-VVIa7oZj6mQ-1
X-Mimecast-MFC-AGG-ID: n5kQNq84Nw-VVIa7oZj6mQ_1793258530
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48b0a199b20so1401051f8f.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 00:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793258529; x=1793863329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TsAQS4rA4H1iNqLsq84hKblFTfrWhP+kWPfdX+CCGew=;
        b=bkhC7wkX80TDMr0jrySIenQ9LIPQkMEWscjm3Nm+nMoLwgMgpJH0BntBG4pfwxmbBz
         OJwQkC0P3UQNU2hXtETahje3JM12DZddx+qi/bT+XEIkZNSEBgs+xvtB1xE9R9mKZgb1
         t2U1rV/PN9Jlx5DwHWFTZxsIF95/r+lh7nZciqdsb6cO048f4VYP0Xd65iRPR2RWN2ll
         bT27LzKkM2+YIHSNKugU/rYeQpLSPe2JHaReH0pcjmx4gV2lj+vPyGElk7nD6vMuuVrY
         yiSC3T2TVmo+1VLlV7HvwG4S6Tf0TO55c9QM9/i4V9NlW8ouKYURZjhuuvWjIwq3byX0
         APmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793258529; x=1793863329;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TsAQS4rA4H1iNqLsq84hKblFTfrWhP+kWPfdX+CCGew=;
        b=eizFii8eOn2o5shV+uOnKWBDY+HCRKyrRuIaEt6KnplKQm3Li3cHQloDlMB/quRbZv
         ak1xdkW+4lUvZdMfjOHXLICgbzw2OEKtOFpzkTOr7tqHkOp3C9mWn8aseyDDZPI14DTB
         6aEm//eW59bPW6os3h0VlRPr00yOgKue9VuQlGW8D++EGJ2GY9h2voDSkP8gd7FBzQuV
         CooOWrWte89xuhfJKAlzt954acFiQJcrAYgigmGYlcBVCjrQBsDNMSDkc77MWabjmArK
         u7yTORN7eFpmUlpvO6/FnVMqhNHaIlnZKB0skaL7wQlBsKGG34NfjvddqMGMg6uKKB3N
         wCrA==
X-Forwarded-Encrypted: i=1; AKwUvBw1WylFy9QsD3v7Bp2S/R4R8r/XvYQog2/uPuiRyZD07v/8Jaumo3J8oiF4ZYYt1rI5dTvB3NQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYK1LLlJiy3BqHuBzkqaLQ6vxONHkdLXmVc3irrwB13ZI161tMRq
	mBY+fcN0i5++mWUj44sBMBTyBBXk3vKTblv0VAJD/XzQlx80xS3NwRK/kfeRXZ0RB+rgO2qP8GL
	VwX7C7WdG+uye78a6838/LLqwe0dwORbAYybwxdx0Mlgx7PGncIN3L6gUMw==
X-Gm-Gg: AYBFou03x3cT4BvVVomlN4fCoVWVYI33G9KCXmVD/9t+LADftS0rBB6yP/pCYp6LE+k
	NVIuNNtFOP+2Ieil1zjMIDa6sQVX2hQVWrPqvhPDf4ZvuLifEEUEP4QFBvhwxdb1azcz2F8fGTS
	Yhf/8/fT8cyM1XqFQln3bPlhIfizr/V3u93C1pVr69Huc/elOCvSl2hKU/m5E+7ZOEBCkatr/zS
	hZvxG2Yn1try2+CQlRhfNQwQMGImd2ZS7tHsC/7Opo0GB2gYZFvQY+QsLfZ7kNFjg48Ifj3YzEh
	hsLgByxATW9SIdC18lNJNHBxWgdmbmfYAy7cbYSZ5Ak4gwer1pWMeLSEBpdm1TzSLCpmJ5/RTfj
	IN67oLIjDEE/7WRc4BUQhYGGD4W+nXd+qZa9cFBRIQ48=
X-Received: by 2002:a05:600c:811b:b0:4a7:462c:6b9e with SMTP id 5b1f17b1804b1-4a967d96eebmr99427605e9.32.1793258529384;
        Thu, 29 Oct 2026 00:22:09 -0700 (PDT)
X-Received: by 2002:a05:600c:811b:b0:4a7:462c:6b9e with SMTP id 5b1f17b1804b1-4a967d96eebmr99427315e9.32.1793258528864;
        Thu, 29 Oct 2026 00:22:08 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1501:b100:9ea2:fd21:b361:8dab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ece5e4asm31993080f8f.59.2026.10.29.00.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 00:22:06 -0700 (PDT)
Date: Thu, 29 Oct 2026 03:22:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Chris Arges <carges@cloudflare.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Phil Sutter <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH net v6 0/5] more virtio-net csum hardening
Message-ID: <20261029030932-mutt-send-email-mst@kernel.org>
References: <cover.1792768096.git.mst@redhat.com>
 <20261025094449-mutt-send-email-mst@kernel.org>
 <20261028154315.4b9f3077@kernel.org>
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
In-Reply-To: <20261028154315.4b9f3077@kernel.org>

On Wed, Oct 28, 2026 at 03:43:15PM -0700, Jakub Kicinski wrote:
> On Sun, 25 Oct 2026 09:50:24 -0400 Michael S. Tsirkin wrote:
> > > Apologies for reposting so frequently, I know netdev bot will be unhappy
> > > with that.  But Paulos's report made a lot of publicity, there is a lot
> > > of people looking into this, so I feel there's value in defending
> > > against all this class of issues sooner rather than later.
> > > 
> > > The issues were mostly found by code inspection, but all reproduced by
> > > me in a VM.  
> > 
> > Ok, I looked at netdev bot review, and there's another issue.
> > 
> > If a tunnel inner packet happens to have a valid header at
> > inner_nh_offset, it will pass all checks, but the transport header can
> > in fact overlap e.g. the real TCP header and checksum will overwrite
> > that.
> 
> Sorry for boring process stuff but FWIW the last patch also does not
> apply?
> -- 
> pw-bot: cr

I guess I need to rebase. Still don't have an idea what to do though.

-- 
MST

