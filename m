Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593BF332637
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 08:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787216327; cv=none; b=OEyDYfn1wFV/2r7PnizJPFVdvXRwacD1QWFV1E+XEpuigUpqYH6G4dgA2MJM3Ip6DL8CjIphARkjKazYAMTSD3tojHt1vuGffgR4zZBH6oalDowL9MUgj3HG07MetTAbRMSSCg7lQC2eIqVa0ZA7iww3qst/evMv/DKCC7ZkP8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787216327; c=relaxed/simple;
	bh=ln/elpPDKk2TfLh6NKGqsih/Wqq2YMxQ4yrfZkjQrSc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BKfv9ugrRflRk7l4CwrtC0YKOrAUAgr3ZjwWIQz4O3FM3D1okltH8RONrSSMBjJrNzT5MSaQ1ScU1GWaZAWQRkTQOFF2XY9baEq7vSvK36GWVdfkOfZ9IhhRgqIw3MR88c1kINpcc+doCreRlk6SD0QSRnoBm7Ca0VBpxkVT1ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7LWJyNq; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7LWJyNq"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-499b02fc590so7227875e9.2
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 01:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787216324; x=1787821124; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JknlQ//I0WlXlRFoVJaL5LjEkwvay6qHMcvugQ9/1Hc=;
        b=l7LWJyNqGXE2svPvQtdV9FYYSgNJjkdJi2jy9LIC7AeB2B2L1C3IGe790k8DOCqZ8E
         2VulE3cru/bdWFaVT0jYvaTTk0jYTPMJo2tHgdG10FnWie0ZDYvMwT6pTSGc3RaKWgTm
         nIdwPDe43YDKYJ8i/Llr+8lW/90Ihy91BAt0qJl/r/IE+m5A9g2gmOjo0xFiarEXJIP1
         pAP0ZZAvG3e3BIWGfudgq0OYGL7K3raWD5eNo062y9V9ljEJncOyjUgo9GEPcWJFIXXg
         k6OG+b3ObKK0bB/1U3b6/TiUdb0131AAPozCJscZZpFhVsJFQumxc8kpl0CozBwlOsnw
         juCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787216324; x=1787821124;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JknlQ//I0WlXlRFoVJaL5LjEkwvay6qHMcvugQ9/1Hc=;
        b=oeiZocFD8gQe55ZjuODiRHknbmPJRxfFqa6BlTwWX/gh8LxISYlfgWMScoF5N5ugQA
         jSdXAJBh8lZPfKGXGeOdN6n9Ju24npSh03oQPmdkMFzo8yKQTo7j8hxFz/xlDqLJkr5q
         VyeGAV3YR/MJ4zDyF6sGV1xnzgF6zb2pSSAVgqyM8KeWpsCZdDYvruRAY3eAzeWznImp
         /8IYg7vJoOZtEMn9bJGzAKhRbfy4KgxabtiuCJutfUMYtVtDQJQfhDfZRNO7TX925Smi
         IVBtncprnjbaiyyFltcZqEaFaRz5aMjRO81YTORVQGxExsmbzIbNQTRCNSa0w4u7vuoy
         6lUg==
X-Forwarded-Encrypted: i=1; AHgh+RpGZWn1Jiy/PchfTutCW8DtWV9X2xA8b0aG8cerBYI9JqmcX72X1uOnhNZYMwNMSo+Cj6Fy2kA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtkAki1sxkwOF8KahKct87/g0Q61qPUuXL5kPDrWRoa8JXqjsj
	lING42hcfyBNMZK/sHLvXe100sZDeyHSwHAXAUrxJg0lTBvpqRzHN0bV
X-Gm-Gg: AR+sD12rRiXNC+te4k/jD8qp5fxIb+rZv6pq1067x7WegRbpSQzpwxqRoaU9cgyi8Pv
	arAUsxnb7aQleyqExZH57pemJ0dBLdziivMhH3TrCuTRRjEMxerwP6yl9xPaHdiQxpIswmTrupt
	r0GVNPkZmEDyXhRTsHSf3QsoIKkD5AhrkLW3uf0KCuTAodmIKNaamVHxfRQ0nuGrYAss29IMr+9
	8g3pXmBqFDR2t2mVbiOl31KFW1yv91AWnEbKMJ4MYaMkI1K6ej7iNRIxe46pFHvJB3Uuy/uhvAM
	BdJw+/3HxtP0OQNpYvVy2Kbvv1dEJ0rx24THFA9f6LzGedrGf5G3uBhVPjB3P/IyFuYJ93zNR3S
	agYiPQGzck1uI80t/8JKPe4YnX4JHcFOJxIpSUSIExFmNebNu8tWRvwh1lTB0BuSFegQzou11Bm
	rUqPzazI3NBNguUdlqgrukiy+3NXV+WBUGixR7sb/tGAmu3UR+tTbjlb5vcoHBqIBINyoLlg5OJ
	PKZdCG1lyQj4pvLWL6DzswhVN0=
X-Received: by 2002:a05:600c:c167:b0:495:4d00:2fda with SMTP id 5b1f17b1804b1-499aa143546mr211856425e9.2.1787216324144;
        Thu, 20 Aug 2026 01:58:44 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa0fd7a9sm163597975e9.2.2026.08.20.01.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 01:58:43 -0700 (PDT)
Date: Thu, 20 Aug 2026 09:58:39 +0100
From: David Laight <david.laight.linux@gmail.com>
To: James <aslan.jnn@gmail.com>
Cc: Raju Rangoju <Raju.Rangoju@amd.com>, Prashanth Kumar K R
 <PrashanthKumar.K.R@amd.com>, netdev@vger.kernel.org,
 Thomas.Lendacky@amd.com
Subject: Re: [PATCH net] net: amd-xgbe: support receiving packets with bad
 FCS
Message-ID: <20260820095839.472818b0@pumpkin>
In-Reply-To: <20260820003853.39357-1-aslan.jnn@gmail.com>
References: <20260819124307.7a9ec5e6@pumpkin>
	<20260820003853.39357-1-aslan.jnn@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Aug 2026 10:38:53 +1000
James <aslan.jnn@gmail.com> wrote:

> Hi David, thank you for your feedback!
> 
> So on my test hardware (AMD Snowy Owl SoC), it is the former: FCS
> validation is actually disabled, and packets with bad FCS are processed as
> valid packets.

So the subject should be:
net:amd-xgbe: discard rx packets with bad FCS

I'd also guess that you don't need to support NETIF_F_RXALL.

Parts of the driver I've just looked at are actually horrid.

All the RMW on MAC_RCR (etc) are just silly any may leave the hardware
with inconsistent settings, the code should really cache the value and
just do writes.
It might be sensible to set RE last as a separate write (done), but it
really does need to be cleared first.

Then there are all the function pointers - I failed to see anywhere that
would set alternate functions.

	David

> 
> Concretely, with DCRCC=1 (the current behavior):
> 
>   - `xgbe_dev_read()` treats the packet as valid: the skb is passed up the
>     stack normally (e.g. `tcpdump -Q in` will see the packets with
>     bad FCS).
>   - The RX CRC error counter is not incremented, so `ethtool -S` shows no
>     error.
>   - Since CST=1 (CRC stripping) is also set, the FCS bytes are stripped
>     and are not visible in the captured frame from user-space, thus
>     user space can't tell if the packet got bad FCS or not).
> 
> I verified this empirically: if the link partner sends two identical
> packets, one with a valid FCS and one with a completely inverted FCS, both
> arrive identically in `tcpdump -Q in` with no way to distinguish them, and
> `ethtool -S` shows zero CRC errors.
> 
> With the patch applied (e.g. setting DCRCC=0), the bad-FCS packet is
> dropped and RX CRC counter will get incremented.
> 
> Regards,
> James
> 
> On Wed, Aug 19, 2026 at 12:43:07PM +0100, David Laight <david.laight.linux@gmail.com> wrote:
> > What actually happens to packets with bad FCS?
> > If FCS validation is actually disabled they'd get processed as valid packets.
> > That would be a serious bug.
> > OTOH the rx status could contain an 'fcs error' bit that causes the packet
> > be discarded and the software counts an error.
> > That would match the historic behaviour of many ethernet chips.  
> 

