Received: from mail.antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B773BB48
	for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 20:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784492126; cv=none; b=gkWv9zQgxYc9GmhUtDSPdV7kOqD3cFxSSKWBkeVOLDplzlheXeFEJc0QeiagcHzHdgUCsGqFLBYHHX0xAXYGAguV8xQuT8710m7tuj7RTXr/Zt5UI2N+US3NZlJwcdp0RiA6Vm/Zlu+A0WFJmYIq76nNVcmSB+ElO6t8KbD7DfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784492126; c=relaxed/simple;
	bh=69HVis64DsC8dFbYTYP/FrsOSDPkUAkrqXmHfFbxXSM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bbg8SH4y2CYT1c2mQ7XPi4ALO15EZvkFMIF1jPisI5HGg4mznUZJtsW+/RuzkMBfZ/OsuFeUrgaN9NYRGeHyOf9BWNeXiYzzPPRQV3IARmql14tsUBcnmvo82giT+sRf4M0AKPTHbB64IQ0is3izYNVoM1QEchi0xv8OfQoRXa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=SPJpt7gH; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="SPJpt7gH"
Date: Sun, 19 Jul 2026 22:09:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mareichelt.com;
	s=202107; t=1784491776;
	bh=69HVis64DsC8dFbYTYP/FrsOSDPkUAkrqXmHfFbxXSM=;
	h=Date:From:To:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:date:author:from:to:subject:
	 message-id:in-reply-to:references:mail-followup-to:openpgp:
	 mime-version:content-type:content-transfer-encoding:author:from:
	 subject:date:to:cc:resent-author:resent-date:resent-from:
	 resent-sender:resent-to:resent-cc:resent-reply-to:
	 resent-message-id:in-reply-to:references:mime-version:content-type:
	 content-transfer-encoding:content-disposition:content-id:
	 content-description:message-id:mail-followup-to:openpgp;
	b=SPJpt7gH1Ga0evvicfy/rkWAr+eQa85JjsPis7hyIxHjC7k1TCQtVuKOulacsT06P
	 ClZ9qW5taI7O2ZVa0qCtQBT38f4Z+hJ0nxujWSl6BvvAyVOIQry9XXSSgabIAvrwE/
	 EQC0GdeJaDSqijgc2yR1ET0hZWyA4U91S+DYcFsf/eEjd8LXbgQmAKVuQnJFSywhyg
	 XeTgQM5oaGwir9+JID2FIOlcX/t+POAQ554JTyVqINdGMA08JoqKFX2SPYI0NUK0Bp
	 wkQdmpwjZquYpjxkRBlfOCwoBZv/WRHsL6EBASEcOBr18E/pTB0VcBYV0OOrZUDu4P
	 RX0Ii1DpkpWLQ==
From: Markus Reichelt <ml@mareichelt.com>
To: wireguard@lists.zx2c4.com, netdev@vger.kernel.org
Subject: Re: Wireguard head of line blocking when CPUs saturate
Message-ID: <20260719200935.GA5205@pc21.mareichelt.com>
Mail-Followup-To: wireguard@lists.zx2c4.com, netdev@vger.kernel.org
References: <874iiyfrrh.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874iiyfrrh.fsf@toke.dk>

* Toke Høiland-Jørgensen <toke@toke.dk> wrote:

> I'm sending this message to (a) see if anyone else is seeing the same
> kind of stalling, and (b) to get input on whether the explanation
> outlined above seems plausible. And, in the case of affirmative answers
> to both (a) and (b), to hopefully start a discussion on what to do about
> this :)

I don't use a wireguard setup on arm hardware, I am just brainstorming...
Given that you just use one tunnel, how about pinning wireguard to a core
and, more importantly, pin the program that causes the 'fat tcp flow' to
some other core?

What you describe must be a common problem on low performance ARM setups
running wg on openWRT (mikrotik comes to mind), so I'd have a look in that
corner of the internet also ;)

HTH


