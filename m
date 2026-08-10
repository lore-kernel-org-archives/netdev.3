Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76236418A36
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786373705; cv=none; b=pSysLY7in8kloizE5ZYKXMFyI2A7ACZiFQ5njxbFcKgkYxhYOMMgL+te7OM7YhyHRHK6zB/gjUGKQELPniqpA5LN33olOwsruOO66uo65j3YKl0r6CIXHnBN/J42P+R7Ju+zzxSW+m/r6Mn7+z1I0kWRf86RUYH+6rdbJceNdC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786373705; c=relaxed/simple;
	bh=D5+5dFmAsh9x2SaDkMhDgf7zlFQc7aImvHgteB7xCws=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgbrnm/VlMPo47S+dfCVHGypkF/B6X1MtknUlFkfqH7uRNIY5TWN0FSsC8pNNa/urBaPlZOZWzy3okg5gstNf3Y3yZ6dEE2CvLjsBghm7dB+sc7DqGsPE5GrEAosmPcpVAQG34c0SoPWg1of2egKUFKRek6aQploJZaas16iTZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjK+sXKO; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjK+sXKO"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493b966dd74so12282325e9.3
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 07:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786373703; x=1786978503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=crMTbgCDGknA6Y+Vym+oYUGfGVtwJH/ps1HJkkbxBQI=;
        b=bjK+sXKOfovFA2FxdLPTPWSa8HiBSZsn2COtd4GmQ+RMrrafvg5PEEnOpg48JpJfaa
         LUlhfHaRrSHiBFnPdFZc+4R5e6erriHuQeZkaGgaDqiScYPMr7nlNf+bc7u/Rs37xvpb
         XqJPxrDYZSU6N2xSR2KxomNbotlZS3skyJCIdJL3MYWznoybvbKacQQDl/vXA6eFFbLB
         ueYb0E4gA24al3csJ91cryij9hs2PSq/Eqppv2VY5Ky5dYV/E/YSQZKwUbMoOnU+vBZr
         Qq7eQnkVzC9U4b30J50OVjDvc3BKKHCvT98l6aPyJU1tINhwf1sFpwJWVCeCJzsAzgw3
         ZBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786373703; x=1786978503;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=crMTbgCDGknA6Y+Vym+oYUGfGVtwJH/ps1HJkkbxBQI=;
        b=eL5TqTcMBQYgGYhbZP/JjOVWbohZ7pTQT+d0oIWdgYGETFWQvBafP4P8r9OHC8abn2
         h/NXSy6mHwfBjSDC9/7hCyeg7IDeTrmIquxJH+Q6CrOGwRCFpWu12jMLEZTBymdDfjat
         YLRiCebirqQUiwwIoIhtFrYriC8okXyV9POVOeshB4zRXxDJjsiBJJWJoQ/TNCmZCGYk
         +OS+k0J7fhCmrxQ/38p0TRdzW69Sb0ipDa1/XfKi4xO9aWPxvUZl+EmhkHxkI1DkiFYC
         974TS05VOPKp+39ryRbXCUV77NXZd5eqEhhv0eNWA9bMhlIpCjsgQusxMKaAOLmfE/7g
         c84A==
X-Gm-Message-State: AOJu0YzQrNQrhUbCIvAQRG1VriReTEnHViq4RjpDUaHaE5uZs3OA7Eie
	Ua6/KbfoQwfsYPfOdpCDOfux/I2X00X7ddQ+vmCL9xpsj+DexDJb7loxe8QWH6Ui
X-Gm-Gg: AR+sD11RKleOWIr9hz+TuCXZZDzcAfs18fX30x/GxRAtjk6YjjxN6jRhfyKL93oiPqI
	PJLpe/ItHBZy8dGXhxrioATMP5PzPfKhihoys+UdhBzlwoYUOLyOkrLj8jbKZKuhFGma5h8KvqN
	cqU7ROKny46LBh6k/ICTNniDMJG9Bjss08oT46R/EhaaXmyB31ZzdT/RoQwKTjnEm0vraSnb10f
	d9quazw2ZC9p8dakkOf72h8Ei/xhCKVkaM6Xk5xIYZ7bHFIbcSu922ocy8vmMTsyZ4NoB42h+Ag
	cpS5JL9bAYZTf+xJRn6Aw9QEE1lOvR7fZzhwZwx/m0xD3hA4W4SuBt1mnHmLaWa+B0wvGdncmkD
	ASbKj2kFPMzPtNRyfp5/Bg5g6oR2Nqcd8WgApt7cwJ5ptdUIiOxAsZruOuDIXdG6/xcs8/IxvKL
	dYREXeozPyU4azjGRniqC1/zMQVEIGTn+h8nCLxMpAc0KMEhL5AcRkZ1bQwFpcj4hi7i/20Nc5E
	HJVxZC6GKBc33tpI5aAeQcmLak94dhI1N+YZEOpQA==
X-Received: by 2002:a05:600c:4e87:b0:493:e460:1f6 with SMTP id 5b1f17b1804b1-499726d7b0dmr27974845e9.0.1786373702503;
        Mon, 10 Aug 2026 07:55:02 -0700 (PDT)
Received: from Ansuel-XPS. (host-87-20-3-207.retail.telecomitalia.it. [87.20.3.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499541b86f5sm413893155e9.0.2026.08.10.07.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 07:55:01 -0700 (PDT)
Message-ID: <6a79e645.cdc69361.35b412.6c89@mx.google.com>
X-Google-Original-Message-ID: <annmQvn-IhB1IrkZ@Ansuel-XPS.>
Date: Mon, 10 Aug 2026 16:54:58 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] MAINTAINERS: add myself as QCA8K maintainer
References: <20260810143740.652804-1-ansuelsmth@gmail.com>
 <caa0b7dc-7f99-48ca-b65d-5d62c0203045@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caa0b7dc-7f99-48ca-b65d-5d62c0203045@lunn.ch>

On Mon, Aug 10, 2026 at 04:53:33PM +0200, Andrew Lunn wrote:
> On Mon, Aug 10, 2026 at 04:37:05PM +0200, Christian Marangi wrote:
> > List all the files of the QCA8K DSA Switch driver and add myself as
> > maintainer.
> 
> Hi Christian
> 
> We normally target net for such patches, since users wanting to
> contact Maintainers are often using older kernels.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 

Should I resend to net with the tag?

-- 
	Ansuel
