Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890613E5EF6
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 08:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787906230; cv=none; b=cVkf6WwD3KHnq7LZRo4qcXInB7u8aRMvoMQvzkTJaLLh7EeWIL3Qag8fn6EwdfUWGOWzSUqFuS9BwFdKYEXEt2HNJSm3+8/zQqm4wEBDXYVJwviejexjv8DsYIWWjuzTGLkNplkIyLTcJD25BvGptsRicM4d9ptt2BK382keQ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787906230; c=relaxed/simple;
	bh=JjimoRVScCSqsPgCSM4g4WWACozV9xBIYZan/cGHbEA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NTORQoNKj9vdn8KV98/ovdEcW08GtCYw4goMqySwhex7HRGY9LuUdGohpugso2CaTI3lrHYbFMc2yIFY2XpTW+v06qy13qnvLjE2BBC1KGzuYfJTXQfrI+Kn5jC3pd5Mm96+QoMM4/vsTjy5iKjd2YfR1E4AqCleGTuI2izpeRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9kJhNEO; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9kJhNEO"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49b0dbfbf7bso4432315e9.2
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 01:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787906228; x=1788511028; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xY6rbTR5zEzizwjLS/TmjAP1rgdrCTsmvdQtVQtF9P0=;
        b=T9kJhNEOsj1kF51Bmky2hbGcUeL2Rtto0QRtEp7USCaEljuIUpOtwCceoM3TAbbpmH
         917IxUrp0WKArqLNfqYyvEzamcl+JKi5zwRSQxVP+JgSKy16AiME70ZVsfQscHMpGz3n
         74BlXyysTu3Gv5KwUZNQ/QjHdz5YdQvJSMBUiyGdF8h9N/JvZrlu+Jfcb2505RsK0CzA
         gkSPZMa4STlTxQ7ua6Iy9MCvrrSC0D/dCOJr9neu+1IsjBCrF4kQG0NRDIP3BfHxrDVm
         85ETEUw0Kzj5TW0TjlEPNFrxHJ1yOqYCXgGubANkBQMgPFW6n+1I6naBoNOPkoKb25MW
         YLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787906228; x=1788511028;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xY6rbTR5zEzizwjLS/TmjAP1rgdrCTsmvdQtVQtF9P0=;
        b=W6qzqiME65H9PrFJatfLB/vNi0OUj3bCxnQLnbJpKcMmAAG8FEd7XKZocg5RqWmuW7
         tjVtGfAkCuPQT1HOmXNtGpD6uLK0SQFjYt8BhvRVhYod1PBN68sOkgJQ0g9fejoQAXTP
         egcumdxAt8tWVPaqTjA2yyHEBp5NnLntjRn8/75mKteTCzwkDTWL8nEDnjqHx807uoLs
         rAwiCdej60YZ6tM4ROX96BlSlHZRLfKAX9OEETCVDuKaKh24EnJozhDvR16mqdQW74qx
         sTj3/aF9/PTYCdGUZDKagkFyro98LRri9JKIHfjUzfuQuouA5t1nDGni5tFxxwdSVUqr
         Vaog==
X-Forwarded-Encrypted: i=1; AHgh+RqU0ZN7EJArc45VqeXA9KA6nLE0NbReYUlZImbBcfV9qAMoKTX9+zwc3IUaP22eJDVArODUC1I=@vger.kernel.org
X-Gm-Message-State: AFuF++mb/V18wi63kT3K9rSmZPBxUdNwt6H4vkpNtKzQskXBwmFrgVHe
	C4wsGTA0ZlCDpIqCbHb+ayNUu8V9C5sq5VsEY5GDn/bGrn6ccUNxcdmF0ku7intC
X-Gm-Gg: AR+sD10uJRhbeLib8PmZPgr8DPY4BB0igG3HC6/TL3ciy1/KusmbGmYcrh7XYndbg0/
	6keOcwFlYhkAkypgtGefa4KgmjQiLIIYMgTRZw+5Akd2m4L8rVNGaXfjQEzGZX8lCX19oVgxhhN
	SR/7OO+hA+uoI/PuwI5rEINpjSOD7pEjqhnbNDyi6Gl2xO39K0Vjtc0n89xpSHZVo+TUxvWccI+
	CRim5d7atwRAvF1vZcDD1CldArXqiWxGozc2IQQVgg0rXwNFTixUvhLNlV3N4yciir9F1YKb19C
	1gQYKj63amlvch0d3DxM9b1aj8/okAWtOvDRnHf3OiYuCDqk4/9kPb7r7x+c2FId/4BxEiz6tNF
	oJaY6FJFeGio3Grq9uVC4sCj+GTG2Xlw07w24KNqHj2lDFYlEdPOqAEffK5erDiJXkNLVDYa22X
	TA91HAaQg9E2ioWTqm34H+tbjM75JBFBGeMn1fz0vxwE27rPotbz8yQAlg+rbQis7NbwN2Fjap8
	MGbUc6jmSrdIonlsdW7SlOkyw==
X-Received: by 2002:a05:600c:3f0b:b0:49b:9105:cdaf with SMTP id 5b1f17b1804b1-49b91c30753mr77538815e9.8.1787906227824;
        Fri, 28 Aug 2026 01:37:07 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b49cc61cfsm121431165e9.6.2026.08.28.01.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 01:37:07 -0700 (PDT)
Date: Fri, 28 Aug 2026 09:37:06 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Nicolai Buchwitz <nb@tipi-net.de>, =?UTF-8?B?VGjDqW8=?= Lebrun
 <theo.lebrun@bootlin.com>, Conor Dooley <conor.dooley@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Jonathan Bell
 <jonathan@raspberrypi.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: macb: exclude software FCS from TX byte
 statistics
Message-ID: <20260828093706.3419d646@pumpkin>
In-Reply-To: <20260827115601.6bf0b18a@kernel.org>
References: <20260824134703.766708-1-nb@tipi-net.de>
	<20260824134703.766708-2-nb@tipi-net.de>
	<20260827115601.6bf0b18a@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Aug 2026 11:56:01 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon, 24 Aug 2026 15:47:02 +0200 Nicolai Buchwitz wrote:
> > + * @skb_len: skb->len as handed over by the stack, before padding and
> > + *           software FCS, only set for the last buffer of the frame  
> 
> counting pad bytes to ETH_ZLEN as sent is perfectly legit,
> it's a driver preference. Some don't because HW pads and
> the driver doesn't want to bother adding a conditional.
> But it's best if the driver bytes match wire bytes IMO.
> 
> Either way, you only need u8 or even a flag for this,
> not a full u32?
> 

You could save a count to be subtracted from skb->len.
But isn't that also unrelated to the UDP checksum issue?

Note that the receiver will treat an IPv4 checksum of zero as valid.
For IPv6 it is a protocol error.

David
