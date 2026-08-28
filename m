Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFF63346A6
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 13:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787922168; cv=none; b=ky80XvgHf3r7mkz7p3wZa+Zev9iPDrtoy3a2HYFCFi4lDGmO3VtmpePFubyvLY0ZASm7F4k8cDBbRPl5FnTkXhU+OsugMAt+9Ce8FBMfzVyQ+OcbhEVE09pPejz5xA7FXUT7+E2/clS456dbf64F2HGDfvc/2lcGCtsElrOV93k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787922168; c=relaxed/simple;
	bh=e0MTBt8C9abeTF6aZrQ7SUmivpXqo1/CfI3Y5wv+uKk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DzOdhKyC2dzhfyC29bCPFNqr0WCNJL4syNogUMvU9M8bzvpbcYn/RGnEMT0FhsIR4aoo4HPR0x1OYlqFiMJWh/VHgMy4zXXwpqTmI6l1HcQbFidq7Zr/loMwIMmjEC2SFTbbFAVMH4o9iAhHHTVSkfNfbSvfaEGZiF1soHY7z4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ru47Pa6A; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ru47Pa6A"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49b8e527d63so8285455e9.2
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 06:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787922165; x=1788526965; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I17XhHckomDClTuJ9XtJEJgl/TykF1PHh2VRHKfngpo=;
        b=ru47Pa6AGYUwflu+pbsQ+894sKNa8SLlSjbEmktLNyBaxoxawZ/DFkhN3+lQ7pEAy2
         Sye/FBkyIdh42KG7NTDuauPm9GdKY+FK4PeGqxL6vsFX3++AI0OkF2q6/oZlJOwp5PP/
         3HLXfMnDfmxurswV0D711C03egJrtrpCFiXZo7pscSD4XgI9sxemHwq6SsxW6kIAZo3G
         EfzXUbE6PTzRv617Oq0ln/2zBKP3Vxam/vgUcd/Thz+ETcBPz/AnalCnjJCGbnllv68f
         FP/qjXK1FcmiqD8oXuYBwbkLIQ7ols+hmxbSihDK7TmUmCRqQqIHW4CH5dyBoFgwcwlK
         M7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787922165; x=1788526965;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I17XhHckomDClTuJ9XtJEJgl/TykF1PHh2VRHKfngpo=;
        b=ejSCT7o8iSt22zc0Z7qbKsBpcb76NzwLuJu8ajYwlDB/1kgSi9hvYK3UBVXb8fY2Er
         u01k/2snDuvfBDsMSe/884k0Fv55MSKT0GwSS3LTaQs0xF0l/Uel2a+WamqMrhwA1v/d
         5kiV3EHFTEVpqT7UUND9V8mv55UJfxRJMXTqmW5Vv1lYq83r5h0qACQ2HMlozCc+aJ6g
         FYoEa+GqoEOGo5rVzNzGhC/cBknTFtNmaum6T1PZPnwSVcr+8FBmJIdmKSdQqKwRGBpf
         wdMaxacDo1ZV6kdqQbTtVi/CrWmD+fIelFNK0TLgqHMVpOPGeBAcpQ3Cy/oLMrngCgva
         b7Yg==
X-Forwarded-Encrypted: i=1; AHgh+RpmlSne27+Y5lA3cFDBDmK8vTFFmNET8DwXYCbxrXKPV4e3g0i6dNjzHmuQIAw+bYJfuBVdcZ0=@vger.kernel.org
X-Gm-Message-State: AFuF++kU/gh8LWCMsBt1CDfxc7bU9m6MT/2tOzUR65aNvaJPqsRfS6Xp
	e6ztFw534JABUDvHTIcoP14L1nHI7VJqIBVcKgaZ+h1la+k7RY8/zT9s
X-Gm-Gg: AR+sD13rdbT+U+QDn3GiV0vdckOHC0iSqy2JrGUCzUWOcurZLxpFdP5OhGvRMx4XRt0
	W/GvTXJC/QJeBGyILoGe20tnac56GrEQ/EuwPitGgWH4EbPnK92OB978ha4auWN3D6YvK4aGNvo
	9I8KdttOqtagQqU73X2Rs+RILkjnPw0u9f/4hZ2JIcAw20y1Bovt3TL7IwPFJ+VZZAnQZHjpvI6
	38+M0RQ0r5kbqbV3RRvI/Ml70PTXAutflaO7AS1/u5bcgJbLzz/n1dFK18ZUTAlnlZkm2GNmfCn
	/9HC2WeV2OFbh1ODig8+afh+RIfFER9rdGALYU+zDvgmf/qp5oj3jK22sd4mhKhF2HTiuYs4L1n
	P7X7WzmdyabpTcBCEGvOJO94UqhGAEfkIU6kAb6QUvKVL1RrXoFELHwHabar8XdYUzH35E8j+Nq
	78H4/s/vHalEVbbV4bELa3vjGr+ofdOCWFJf6xyecGm6XLgZ04fMb0Y5w3hldgeEbKxMJQm3iX5
	CPJ7tTNfS95uNV+ssVZQLJzxw==
X-Received: by 2002:a05:600c:4fcb:b0:499:db27:7b1 with SMTP id 5b1f17b1804b1-49b91c62d9bmr94595575e9.15.1787922164498;
        Fri, 28 Aug 2026 06:02:44 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b4c321184sm165459595e9.11.2026.08.28.06.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 06:02:43 -0700 (PDT)
Date: Fri, 28 Aug 2026 14:02:42 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Jakub Kicinski <kuba@kernel.org>, =?UTF-8?B?VGjDqW8=?= Lebrun
 <theo.lebrun@bootlin.com>, Conor Dooley <conor.dooley@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Jonathan Bell
 <jonathan@raspberrypi.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: macb: exclude software FCS from TX byte
 statistics
Message-ID: <20260828140242.7c78d4cd@pumpkin>
In-Reply-To: <36165fe4a906b07dd9f92a73a72a05f1@tipi-net.de>
References: <20260824134703.766708-1-nb@tipi-net.de>
	<20260824134703.766708-2-nb@tipi-net.de>
	<20260827115601.6bf0b18a@kernel.org>
	<36165fe4a906b07dd9f92a73a72a05f1@tipi-net.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Aug 2026 10:20:24 +0200
Nicolai Buchwitz <nb@tipi-net.de> wrote:

> Hi Jakub
> 
> On 27.8.2026 20:56, Jakub Kicinski wrote:
> > On Mon, 24 Aug 2026 15:47:02 +0200 Nicolai Buchwitz wrote:  
> >> + * @skb_len: skb->len as handed over by the stack, before padding and
> >> + *           software FCS, only set for the last buffer of the frame  
> > 
> > counting pad bytes to ETH_ZLEN as sent is perfectly legit,
> > it's a driver preference. Some don't because HW pads and
> > the driver doesn't want to bother adding a conditional.
> > But it's best if the driver bytes match wire bytes IMO.  
> 
> Matches what I had in mind for my v2. So the driver bytes would match 
> wire bytes minus FCS.
> 
> > 
> > Either way, you only need u8 or even a flag for this,
> > not a full u32?  
> 
> Agreed. skb->len at completion should already do the trick (minus 
> ETH_FCS_LEN).
> So a flag would be sufficient.

If you make the 'flag' 0 or 4 it will save some maths (and maybe a branch)
in the completion code.

David

> 
> Thanks,
> Nicolai
> 

