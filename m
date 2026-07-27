Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E663CBE84
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 19:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785179509; cv=none; b=l4Vf1W4XKd5HycB8tFAG3W5Sz9l7isgpKlylbhr6F98Q3+/QxX2ICFkTt8hUguQ0AW904vXsf/gU0Nlm5DQ7wfjSYEATIUQUDGZ8HyipzgTwHFY8GYb+UBIt2QcXmTZ0m55Mm4ot8u21Fwjm212jjXNryx+8miT2GFgNH9x4MZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785179509; c=relaxed/simple;
	bh=w6Zw+XAq7csIa/unli2ye+IWWMGO5uUs3dYLEr9E5n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RX7yHphZrf1FRFcXhzjpkV9itwWvu5ozUeQeqN4DDQ795gZRrwPNjeZJc5pDSQFhAdg9eBub6ie9ejapXekScIW4ttRwbuHXYP1/MAAuK9/G0kZ+0qhyhunDQ4VoU0sdLmkQH4lQVHRuKuULuYFC1XZal5PHU1swdzl5z/4Yyn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DzpEAuWg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fIP7mm4m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DzpEAuWg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fIP7mm4m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785179504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WCGz+BwFtWySUH9n8dnYvmC5KiNUSY/TFMZPl7CdAE8=;
	b=DzpEAuWgsGGrEuQe41yYPGQWi5nheeUMJUg3pqYHJtW1e2P/+zE6Uvl/Nf8G52tSyS9g5B
	q6abSr7Kpx4jU4RhpLd9t68I/T501PGjHQmW+Cwi23JlyJ5xBOjHgQeCT5U/LfG9S75IFJ
	2gI4akYSugt6YGJgf4/se58u7Qi7eHQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-R1Ow3jRLNKaDVy7M3qM-Rg-1; Mon, 27 Jul 2026 15:11:41 -0400
X-MC-Unique: R1Ow3jRLNKaDVy7M3qM-Rg-1
X-Mimecast-MFC-AGG-ID: R1Ow3jRLNKaDVy7M3qM-Rg_1785179500
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f5a972b0eso2467070f8f.2
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 12:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785179500; x=1785784300; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WCGz+BwFtWySUH9n8dnYvmC5KiNUSY/TFMZPl7CdAE8=;
        b=fIP7mm4m1dKzL/vLU4TpG4Zpl/xIPYlYy04FGAoic0MyqZmd32+9x+wqur53iiSmaN
         0e1isBrwkc74MiKIK+DpRfXLN/Vu3jyP4PUDez3vLoTWTP0La37KeDIZDsaRhkiBO6mg
         3D22GD5gjjFoN9Kxbc/9vKnYjtVVrt+jQhk9eyhp7BGcmq20XKhK8dcbek+uSWWk8rd6
         0TmrlZY+R058LPhN9zpEy7qIY76eJ4d5Uj0JfVRgcSJMZ9BdDHivVMYPAT04guJ36E3W
         JuOvEuR8gr1nJiwAdbU2I58WBlUCOPdg5TzYb95XePR+AoQM+PPD8Pyt7MIRc+rVwxnb
         wQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785179500; x=1785784300;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WCGz+BwFtWySUH9n8dnYvmC5KiNUSY/TFMZPl7CdAE8=;
        b=MaLqU+VUM3OWfMMg2Iu3Pst4ZMJN6RjJPwytMM3gZNOAT1/yW+0NOutJZuGysnOubm
         DG2GUdHh5zzZ9Y7N6B1Z1eur02GYRVGJkH22ynvuRAkdrcw0/AQcNQMOdprbFrULWQ1G
         cdPjkyJ3H5QWol7ol/zZZQ/n0xlyF1l3YvmeoRdMnJFCXRnvbzGFuQT9eYwBrOEUHPfP
         PKRW7SOAZVK7IC4GjoCqYpmzPh2fgXQTSgBQibX4n8qW2cN+o5zlK2gka4P6crOBOS7H
         IHdVcZbMrB/M5Vcmtf6npU54Uzv3XG/0rEBmE2pIg8uc2a0rqOtqOpS4R5xZOAHJOXYB
         wMYA==
X-Forwarded-Encrypted: i=1; AHgh+RoBjM3L2ATjaNRs/P7ewzi0A+eQdp06zJbPcc2r43dl/ef/4yoXKPd1HyQn6pWagIgF10k0zKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVmlXqTuOXPLlhuCgWHKpm48v0UYawhsgoXsiEDljrjLfZK1CG
	7acvzCxbO31RLnnwtRLsa1/ip0F69VSPFKxr9s0Pa6mqtcU2oXvXQhc18pvINATTB4fphmKlylI
	6GwUB+oSCe+burXHGtQpXlCxa599lSl/9GXZAa0oJK3jij43wRSEZL6sZJA==
X-Gm-Gg: AR+sD13dHxLVlJ9/JmSP4ODhahEC7iUc3DJBuza1u/aykyWKRfv9FKSYo/uamjDFrlK
	5ciwu2BGuWclG2X51HLZ8ceDNuiSEBMWN/6n113dORDwv0wjTOGksm+amFAvn8RQdrGw/e3skPc
	BzS/h/oHPJ3G+x4xuBdGJRSCsFK7lDWDt+DjV7fmlJIdtiPbMMAac5PdG5GKkyaVYTeCQ/204wF
	goPOmR6HSxfF2/kPqoGxUXyVFa3GGJ8av1rlYBaaR40F6SsAu+O9vdxXw7esMDuIfJyjmBggj1K
	IYosZ2PXApL5QoD+pA9VwpGQ6JIN/dCMv1OmNSUN8YhEdxyKxb/cv3YnujC8eDziaI0azczhszW
	Gd3BEzICg9Bp+mJ0qIgktcw==
X-Received: by 2002:a05:6000:61e:b0:47e:4379:a4fd with SMTP id ffacd0b85a97d-47fafa50cb5mr459978f8f.19.1785179500297;
        Mon, 27 Jul 2026 12:11:40 -0700 (PDT)
X-Received: by 2002:a05:6000:61e:b0:47e:4379:a4fd with SMTP id ffacd0b85a97d-47fafa50cb5mr459953f8f.19.1785179499787;
        Mon, 27 Jul 2026 12:11:39 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c531afsm56615929f8f.24.2026.07.27.12.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 12:11:39 -0700 (PDT)
Date: Mon, 27 Jul 2026 15:11:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>,
	Brett Sheffield <brett@librecast.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net v3] tun/tap & vhost-net: make qdisc backpressure
 opt-in via IFF_BACKPRESSURE
Message-ID: <20260727150842-mutt-send-email-mst@kernel.org>
References: <20260714092506-mutt-send-email-mst@kernel.org>
 <5016ae84-7049-4a5f-91c9-ba0047b06ee3@tu-dortmund.de>
 <5089fc5e-2fb8-41fb-9aab-42b22cc2c201@tu-dortmund.de>
 <20260721105853-mutt-send-email-mst@kernel.org>
 <20260721100715.5b43412d@kernel.org>
 <20260722020611-mutt-send-email-mst@kernel.org>
 <8814700c-7549-4d12-b657-c990dfeec14f@tu-dortmund.de>
 <20260722040722-mutt-send-email-mst@kernel.org>
 <20260722072631.21b57e1e@kernel.org>
 <a8dadd41-e2c5-4a6b-bb93-77c3d5eb6342@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8dadd41-e2c5-4a6b-bb93-77c3d5eb6342@tu-dortmund.de>

On Mon, Jul 27, 2026 at 03:57:51PM +0200, Simon Schippers wrote:
> On 7/22/26 16:26, Jakub Kicinski wrote:
> > On Wed, 22 Jul 2026 04:09:25 -0400 Michael S. Tsirkin wrote:
> >>> Would be great if you could do the revert.
> >>> I don't want to mess it up. :P
> >>>
> >>> For the re-apply:
> >>> I can post a v13 to net-next soon with the flag included
> >>> into the existing commits.
> >>> Or would you rather take v12 plus this opt-in commit as-is?
> >>>
> >>> Thanks!  
> >>
> >> jacub if the revert goes into next what is the process to
> >> target a patch on top of it for net-next? Thanks!
> > 
> > misheal, revert will be merged to net and reach net-next on Thu after
> > the downstream PR, at which point you can post the net-next patch.
> 
> Hi Michael, do you have this on your radar?
> 
> Thanks!

Yes but I have some urgent fires in other projects to put out first.

I don't have anything at all smarter than git revert + some testing in
mind. If you want this to make progress faster, you can easily
do it and post and I will ack.

-- 
MST

