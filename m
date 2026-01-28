Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB80827B4E8;
	Wed, 28 Jan 2026 06:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769580708; cv=none; b=k/Mfcb1F24tyWDE+jxhOxQZB4bmc1Pka4mKSdJTQTzyZqjKt2kQ9vOVzkb0aC0eAN8J8rtZq5aL1WxophXAWM/In1eeckCadrcAM08DESHfhkPxOWx0TZdQoTBQrSbqI5wdsaIrn1D8thyzMI8nUjKLUy1pD71RF7kgt55Gz32Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769580708; c=relaxed/simple;
	bh=JXmx3ru6DbNGgSS53SUU+Z+OgHwry2j4I+n2aYrQwCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAKSzZkdaHJtNB5a2mX4MfQIqoLODXAHOvZFOCN0rKycBIFnd7nVI0+wV+MDbtxsWDlbLLhdJs6JXESh2YYEejDem3eLGkKoUYpKswuH6MY0Y099a4k9OyU3o/v7MsDD8gDpVqVOePP3vTe/E2l8CYhE37bkmcuZwQahmwACsQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k9NT9y4J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k9NT9y4J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8DCC4CEF1;
	Wed, 28 Jan 2026 06:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769580708;
	bh=JXmx3ru6DbNGgSS53SUU+Z+OgHwry2j4I+n2aYrQwCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k9NT9y4J4ceqqk4QjELnD3ZXmNMp7zvRkys4VW9AQ/9NFdtdkdqJuRhdUSKIf0DmR
	 FjbJ2VCcz82PFxcxH46+26PoBeCNdA253BYNBpIhSnlovZcm+HFaDro52U8nrDf7Ri
	 MOmx4BcJIxKAtCGtZkjGTMJaDcjyz4Lv6rQIyprU=
Date: Wed, 28 Jan 2026 07:11:45 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ivan <kernvirt@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [BUG] r8152: Tx timeout and xHCI setup device timeout. RTL8153
 31.00
Message-ID: <2026012811-sepia-aeration-0238@gregkh>
References: <CAOf3c5fDit7nvfWUGf+f5Ctmfr9ebg6KqiwZhZYusHyFaeE5CQ@mail.gmail.com>
 <2026012758-dedicate-desecrate-358a@gregkh>
 <CAOf3c5eJp7432wRk1E0cDTWMccO_m9fWYDKU25-qJ7Owk8mVQA@mail.gmail.com>
 <2026012720-outmatch-worry-b92d@gregkh>
 <CAOf3c5dCsN2rDURv_Ct_K2agiFRe1zEjrQi1AM8LjTCfUYnLVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOf3c5dCsN2rDURv_Ct_K2agiFRe1zEjrQi1AM8LjTCfUYnLVw@mail.gmail.com>


A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Tue, Jan 27, 2026 at 07:02:46PM +0300, Ivan wrote:
> Yes, the log is correct; during the time since boot, I had just
> finished downloading those 900MB of packages. In this specific case,
> the interface disappeared just before or during the reboot. After the
> reboot, the interface did not reappear because the hub remained
> powered, and a physical reconnect was required to initialize it again.
> The previous log was short because it contained only kernel messages.
> This time, I am attaching the full output of journalctl -b for more
> context.

Thanks, but it looks identical to the previous log, the device, at boot,
didn't want to talk to the USB host (i.e. your computer), and so
disconnected itself.  It must have gotten "confused" and so a physical
disconnect from power fixed it.

That's a lot different from "it was working and then it stopped", so it
might be a firmware bug in the device?  I don't know, sorry.

If you plug it in, after the system has been booted, does it always work
properly then?

thanks,

greg k-h
