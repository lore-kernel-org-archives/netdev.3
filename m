Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A2C499F36
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 08:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792400051; cv=none; b=axeiMuNJjabtpscweYNS3/JteNkvO0ZewDJ7I0q4/cz6CFly0C4jXb0W0bDalKBLE8OzajWeTnd1lI0rOGuTu/LBUInF838WB2vthUV1AyfRFJHsI3LaK2ilfcK1FMpo5pVdwB1IAabVXbgAktgY0G/GEFPT9caEupRnkFXXmL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792400051; c=relaxed/simple;
	bh=s0h42F1lZrfKQV3xJxTI1fXSkem6mtfA5ZtwhL8W5+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itbQ3zV4IVb+vqKVlzhFJ15jzHPmIMvBOrh+oUSBHCxFtOFq84uFUGbxefBwEn/Mnl/Ul9SeS/rgzDhO4tfLrQTH+HptQDQKyfHojFfg+hphgI/2OY95AU15lXErxofFvTZNfJJ5flw+AfBGLLq+fCQwP3tVbOYN1xZ7+DovaOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=OVJBhzyz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LJCuDaB9; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="OVJBhzyz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LJCuDaB9"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id 151021300471
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 04:54:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 19 Oct 2026 04:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792400047; x=1792407247; bh=s0h42F1lZr
	fKQV3xJxTI1fXSkem6mtfA5ZtwhL8W5+0=; b=OVJBhzyzaBLcB7/1yIs7vivDBh
	NPIjyHnrwgWvSO76cafUV+b4L5bdfIvTEym94+D8qMKJeSdubIHM9UJpPe5Ai8sJ
	0Madw0ec0BPipSMwGLpkXaZRytg4rvaSrdi8iNA+kK6NClFtaOlgIYVYAlMGRAWO
	4tTCWftQDFW+THwZFNqS5o/u5sLTCCZ+I7zFGhGyzqVb7Bsx4sE2XWrxFYHlagga
	xSh4mI3uHsodHRIWVf+4kr53mqWh2ghtpCFMY+y47LuR7TZ620A76V+tTKTMV99s
	IQXhUcj8VnaZkXiPVOB2zlc8YX5C303lkjZL158OqthN2wZkvn7NTQXh84Hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792400047; x=1792407247; bh=s0h42F1lZrfKQV3xJxTI1fXSkem6mtfA5Zt
	whL8W5+0=; b=LJCuDaB9B5G1z4hQmTGw8fY9toMatQjtBixrMZZyxyAd4veFalR
	+l1xqHBwyMctN5riaUK/7sG8QIy7irPOGdDs0qKxpdfaKIZRlCVddjLvgjIh8oMO
	oraFka1iUHpp+KQLYz5A2CCTWd3Dh9rNEPAlwQIirbcEZZ9nX4IvDbsXl8HA+Hj4
	XRtLvaMHK84XCedRmrkLJLvDRXoj9aFxsLN/v4RSYmR3zTgAaJpJdYWM0odSY/od
	22UqSu2CWNaBXczT86MGZBIlR6pOmZDsIjHnUUNfSq2a2KzFFvIym7uXNN115utZ
	IQv1uDDf1TLT9hjZltNRgeR+vtyV7Cas5VQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=kroah.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792400047; d=kroah.com;
	mf=PGdyZWdAa3JvYWguY29tPg==;
	rt=PG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:lLekPtOgh9EENKSLx9DsXJr2OoGxW4Qx98bhZBAGQrpFuq0
	VGe7+v1Gh++twpCaOx4AztV72UFYRDZa5P7AnW3eR24Qjv3srPCP8/sQEnV8PpLa
	EN/5pTtQmDFA5lMnvG3dQbz1S0uISLhIM4bcrrhYCPDbldqZ4NazqJHtoFQ0HFCl
	hW0ycdNROSANO0RG7IL/lp13RjTSEi43mgs43FmGIuQ5UYCkNxRt2svxKaV6chKB
	qyidrRsYw8k437ePMt8WIOcsyt07no9hjyBKSdIdLXjV2a4VPrmkAMCxS08jznWy
	gyAsTa9HefI32CCC6biXx284Sldxa+PmFa3cXxA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:9D9cuvixjsrzA91E8Vh6c5TIaNeU0o52gGMb/xNiTxY=:s0h42F1lZrfKQV3xJxTI1fXSkem6mtfA5ZtwhL8W5+0=;
X-ME-Sender: <xms:rtrVausy3atZo9wcB-BuPuAE37RyNlqLrJDLsb6ytaa5fAh7ckaw0Q>
    <xme:rtrVarPDF1NIEbkbR3wy4YeLHlVEA57NpiE0itcoT5ISGdTE6wuuaws2fm9l1MTn0
    w_ba9JkPkZOiGvKFSSHYwLggo0BqJ4omqI5VuQrm_25-5LT>
X-ME-Received: <xmr:rtrVaoVLZ0GW54e_Up80xIuahKKYuzTphArCDNW45_J095TJDvLpuhinVln5KbJVv1EDIDb6vXy2_h6pqDM>
X-ME-Proxy-Cause: dmFkZTFI49Iqxxv7cRs47BhKcW33yl0sPHw8NjeMputSVefZXoC9ioiGoKQK7r05AXEgKe
    wB6DV8nhv/w9kCWezeGPUPO+7KEJ5aYU4h70bVLz9KJI443Curh4LFxFMbiwdM9kOoIaSq
    vM28RDZ8ccUWPscCzB95TujvaOQhJDr5DDrjfwy1GudwsGoX8qpsWgzUwzODIr2eoYifCi
    3hsAJ4pzzprHA7vneVE0N1EZP9QrAv+TnDRlxkFqX16pac7L+b4PYATTy4WY0/0ZxO1ofd
    aGPMBHrJlVHJ89gDHS1nj3FuGyPFEjvH85Tb9Z4RjyXnjIhXEG8Ypmd1eZwcOu2bQm9IJi
    UQ0Rc4JNHxO6wqzop582e5HO+8xmwACE8qxWxogrpo5TVg0ONEpdzhW8Dmd+gu/DljN7pz
    7+5GtbpggLZZZhY0/9K0BVuZNEtATXNdqiUNYIjAphmUACAwId6QiLLrmkREb8fwNVAz8J
    J7sdl78gokfA8HjwWWqw3tzleMU4dqmuHw1V53BrM0+fid5SrhgpXPuF+LQjCbDu7Yuhli
    D27tdZTVKRDrghjThGgcth/h7kjP/yeG9U+fjJBO9KmdQ2dwst4wbNsE55bbL0IV2TDnz9
    MoWT2Wk24bz6eoPFx1VLQvvsupxVbBKlHgUTMhTGvkYSD3bQsjJB79PlDxzA
X-ME-Proxy: <xmx:rtrVajinA5UHRZfhhGhtePoLIghiq58-DsDlAe-dhugh3x_8SPAXdA>
    <xmx:rtrVai0uK_71I8CtqzjmC0NdMFERbyQpaLeEf-S3REHFzHwZZaws5A>
    <xmx:rtrVal0gztz9fka65a6s5uxl6tOeketDWwpTQPET3N2_VDuGTYNYdQ>
    <xmx:rtrVajyFWN4gEYIXpeAh-5T-CKdiLyivjNmSD9ObbPlhuGxicU9sXw>
    <xmx:r9rVaj6RWDa5J9svzH_Vz3cdkBOBqf6KPzGLgYaWJDs2HWAFHVZyqyd6>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 04:54:06 -0400 (EDT)
Date: Mon, 19 Oct 2026 10:54:05 +0200
From: Greg KH <greg@kroah.com>
To: Pranjal Kumar Singh <pranjalksingh92@gmail.com>
Cc: cve@kernel.org, netdev <netdev@vger.kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Paulos Yibelo <habte.yibelo@gmail.com>,
	openvswitch <dev@openvswitch.org>, stable@vger.kernel.org,
	"fw@strlen.de" <fw@strlen.de>
Subject: Re: Kernel bug report: unguarded deferred skb_checksum_help() writes
 corrupt the previously-validated IPv6 fixed header (IPv6 counterpart of
 commit 6785011f8b16, "ipv4: validate checksum_start before completing
 checksum")
Message-ID: <2026101930-magnify-motocross-6262@gregkh>
References: <CA+UYBZDMpqq989aWq318+T2j4+PU7giVpO8ZffrkDFwqaoKjJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+UYBZDMpqq989aWq318+T2j4+PU7giVpO8ZffrkDFwqaoKjJw@mail.gmail.com>

On Mon, Oct 19, 2026 at 02:13:04PM +0530, Pranjal Kumar Singh wrote:
> Bug report and evidence
> -----------------------
> Dear attachments, all under ipv6-csum-start-submission.zip:

For obvious reasons, you don't want us opening binary attachments.
Always submit everything in plain text, as our documentation kindly asks
you to.

thanks,

greg k-h
