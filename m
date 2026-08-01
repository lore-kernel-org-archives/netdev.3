Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426373BB9ED
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 18:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785607713; cv=none; b=t2fA6ODu9NdPQNfVHf+UeFQ7UkbKanS80HG3RS5xhjspeLM4ffHBwz6HvO7tc7vMawPDZq4kiW5qB89xEFAzFdgH7+gMkJkwyIl+myWCSCCkjyvtW1ExJPFihM3r+MhVB1WDcb8SgM31l2eBEGNd6LEDVS/IDiSDcTtIMhzIn6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785607713; c=relaxed/simple;
	bh=lxpuI5CbP0u3jPOT8yD/nolY82GAl37CUBjAJibkY60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHTNyAEZz3ZIIHD0gf+xZNbAOqT8Q50hW7ekE0DHgKfy63s4Q1mJQJTgmBkhmQo7IlkO2M9WNTtXDVo1FgQvsnoK1hLiYoTaH5Y60mDZORh31zKWcsAqbfJiBKBl9XntYyzSNk1V6QghdSUQ5hUej/BikfRG9rdU6WWsjTXLPyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTyTKnlU; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTyTKnlU"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4956869750eso4751505e9.2
        for <netdev@vger.kernel.org>; Sat, 01 Aug 2026 11:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785607710; x=1786212510; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GoKuAe1ZJwVudeoX6qEMfcN9CIqJIfcMaWyYss3w9Wc=;
        b=KTyTKnlUZfevtH/Lvon1vaf0u+rhX3FTuV1Ix3gfCLBIERpzuMh/NYG63D4HWC4NSi
         UksuoOIC8RibxmJ8N6USYrrMJ10NlkSMbNWVJ5qEbls+UzEb6ZvT8FcNpm/v+nSb2+kd
         kGefNlJ9q6gWzM2n0DrxHa7pqTYBBiPoe406T6GdEH/EpRSM6tQx7iXYm3mn4DXQq7vS
         hRYyyfKnM/IJjIgFlE+hSAvQq91AsCox9kdOmfgOxD716Jt0s2LGmGjPUPdKd2UPlHnD
         EDPG9Y259qnh8+IiAglVrSSSghS9G3TpHoy2W2BdKZ/PtjqBYhTvSKqL6+O73J7AgMF9
         LvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785607710; x=1786212510;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GoKuAe1ZJwVudeoX6qEMfcN9CIqJIfcMaWyYss3w9Wc=;
        b=DqOm1usKez3zcymkq/yEy4lJuYFPD/2GoYPzK3TNA3QwdDweSdLdC48P+677wQ+4pt
         +Gg65U7q2RlmmEfuV/4zgrz7jVFv4Q9ltuxudjVZFdsDjznOpLmF15yahiMHSno8DnII
         5sNVUM1ilc0VIBU/9MOcfL48XGqFam/o4NJ0Iafpmo4mYPe9JO8rE1OfyBLfK9zHWLuZ
         4d1fOppwfTlePeYL/ibJ+Ch3btEBCfjyOBXni4szelBDbsc80J4521WnP2qcdGl8v9PJ
         pGsA6dCbudH7BVWb9G9/18L95gUHkRM1/jsjeq9jJOe5hw68xZClBCo9tM3faOWDNPTV
         phgQ==
X-Forwarded-Encrypted: i=1; AHgh+RpojccLyo4wo45esqkTdW7ycTuW1gdFw4gIFeEFxpZIyHqRsbwjwg4ZmnTdsns6u2NiC708vvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSQ29CD39x0CtlEtNp8UxWdT6Z1D5keA+onKamJOuiYscNk+oD
	YUcl1bcx1BKWz8sFf/HlYnuoyhn9grRt8YBVLtYjXkALQCWxrnL/zVWb
X-Gm-Gg: AR+sD12McApKv16JLb8XUfG1HkZ4qpr+doXTPcwyeIzNNruQZOaivJPGvVAcbztHQEh
	etshhg13Ucn0T1GOS965E8iwpVNQigBQGeDKip7GRW9JBrgW0gPFe1EbHwhculSBmOxNd1HLh2O
	qdu85A7x4PJaLXT+jrI5sN47n7emxKem3CJEV8dksVCn4ZFVyiItVxT5DqpeR//QkQsKPaIcF3W
	VXmg8CgKIHFYOQfN98NogmeauKxs5Yg8V8b0yb553n15HY4xK7GunkGHUgwrxCaTYblxOSxtpDd
	fKdV3KwFe0w0OVA1OewsYBFGve9SGJgAIFkaF25PVw+a7BHoxuxw6N0on2GQgm2taxzudWYZLPR
	34/QRnXFjhKByJtfYsaZPo7+DLH4YqgVoma+UjgxrWTUu159urXXCJlFAoYBPMwpw8/u4WDMPAs
	hQxlssT9s1hIVGVo+vfpGudykcehx/bMK4UZIt2uGlJaDfeHQgo28F4I4LD0x0prq7QMty5xRop
	eWpth867Tv9ctPfeuY4iVkXgC0QW5rSGv5SH3/L2GRP0aYulQh8K9Z9tggiTnJWS3Q=
X-Received: by 2002:a05:600c:4444:b0:493:f6f0:d66b with SMTP id 5b1f17b1804b1-4980c6458aamr63753465e9.1.1785607710294;
        Sat, 01 Aug 2026 11:08:30 -0700 (PDT)
Received: from ThinkPad-P15 (67.85-86-63.dynamic.clientes.euskaltel.es. [85.86.63.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49808691014sm73950685e9.11.2026.08.01.11.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 11:08:30 -0700 (PDT)
Date: Sat, 1 Aug 2026 20:08:29 +0200
From: Pablo =?iso-8859-1?Q?Vallesp=EDn?= Aranguren <pablopva014@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:TULIP NETWORK DRIVERS" <netdev@vger.kernel.org>,
	"open list:TULIP NETWORK DRIVERS" <linux-parisc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: tulip: xircom_cb: drop runt frames before skb copy
Message-ID: <am42Hc4EE2olUMcG@ThinkPad-P15>
References: <amzqfjeo0Yo1p0Rd@ThinkPad-P15>
 <20260731202629.10ff97e6@pumpkin>
 <am0L4gNtPJaMPx_9@ThinkPad-P15>
 <20260731165555.50741429@kernel.org>
 <2026080158-next-diligent-b4ce@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2026080158-next-diligent-b4ce@gregkh>

On Sat, Aug 01, 2026 at 09:04:27AM +0200, Greg KH wrote:
> On Fri, Jul 31, 2026 at 04:55:55PM -0700, Jakub Kicinski wrote:
> > On Fri, 31 Jul 2026 22:56:02 +0200 Pablo Vallespín Aranguren wrote:
> > 
> > Please send a patch to delete this driver if you want to help.
> > It's ancient.
> 
> No objection from me, that fixes all of the issues!
> 
> Pablo, want to submit a patch for that?

Sounds good, I will submit a patch to delete it.

Best,

Pablo
