Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2A336EAAE
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 15:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584313; cv=none; b=OBCN8EysnOjFfLpy3jDMs9A7fj3MWq9LpKBP7rXuDVzjnYyXt/bj9tgkEj24+aa0FU3RngAm4FBT98gLwo3mkFBCVbIDeDxsD6lTQI/hNfZj1YuErlGPVmyFOSmNKr5MLl9TCfG6hn4ukI/gxOK0f1SPLe9kD5kM7QDhuLbSCo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584313; c=relaxed/simple;
	bh=d8ui/WiyJ972BJaFhdt/Rp/05hFEx7J86nBq74tNX6s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=emr5cDQA4SjhiIuYP5/LSE2znLil4X6H9ux8ovn0rh0dE5xyhzNm1ggKW9z6NWCTtkyDg4S8eOUBTI3/xU0rCa46mac7Ph0wPopsu2+08uGw3KgZ+3VHfbvVl7DXVwHLEf9mCVUt1VJ0UO4flQbJrpYvhYgMzgdTxyGMk4NTxBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIvbJZOB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIvbJZOB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE2091F000E9;
	Mon, 24 Aug 2026 15:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787584311;
	bh=h70IIaWa0slZ8JAXXi+A9370yTaqPxMYwDbxWMitVcg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KIvbJZOBzcfEzTfVv64aL7b4KVYf/75NfqDnnuPV205EAT6uwpg9qzVwNm6scpbLK
	 ahaxdE9w5VDH8fX58iv5EqyP5Z9kUWkmBSyxwzvnsbqAx/Z/qdkPjO9OlN3wwdukau
	 HwnQyffypZVDijjkmNZV/hUX2BrZi0FzBIg6IY7FMrTxu6LnH3m4XRqMXlmq3UptBs
	 wFCOALSHJ9FCTVhGpRZQFNVu7z8WBbWfDeOQkynCC3PuC8svaHAGKN2SPqcHobzvDy
	 MrhLu14rCBPn4/5Th/yZgsLdQT8KzMIr6DFjQ8lwbuVmDZLz5/stp+Ekekwidvz0X7
	 Qkp6kqbJY0GFw==
Date: Mon, 24 Aug 2026 08:11:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: daniel.zahka@gmail.com, edumazet@google.com, cratiu@nvidia.com,
 borisp@nvidia.com, kuniyu@google.com, netdev@vger.kernel.org
Subject: Re: [RFC net-next 0/6] psp: use virt cookie as Rx steering hint
Message-ID: <20260824081151.4a37c3c6@kernel.org>
In-Reply-To: <willemdebruijn.kernel.1157fb673940e@gmail.com>
References: <20260822225524.2328465-1-kuba@kernel.org>
	<willemdebruijn.kernel.1157fb673940e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 23 Aug 2026 13:48:05 -0400 Willem de Bruijn wrote:
> Jakub Kicinski wrote:
> > This PoC series uses a field of the PSP header intended for tunnels
> > to auto-steer Rx traffic. Various attempts have been made at trying
> > to get Rx traffic to land close to the core where the application runs.
> > By default RSS picks the Rx queue based on the flow hash.
> > I'm not going to cover all previous solutions in detail but broadly
> > - we have RFS in SW which looks on which CPU Tx happens and backlogs
> > Rx packets there, it is quite efficient. aRFS is built on top
> > of RFS but tries to program flows into the NIC. Some NICs have
> > a "cache" and try to automatically remember the flow to queue
> > association.
> > 
> > All those solutions are entirely local to the receiver.
> > Ideally we would want the solution to look something like
> > TCP timestamp option - we send an opaque cookie to the peer,
> > and the peer echoes it back to us. Our NIC can steer based
> > on that echoed cookie.  
> 
> Another option is to reverse RSS entropy. This requires knowledge of
> the RSS secret.
> 
> Especially with PSP, the outer UDP source port is defined as flow
> hash, so can be used for this.
> 
> Have the receiver compute a 4-tuple hash such that it knows the RSS
> block will select the intended queue. The only free variable here in
> general is the source port. Then communicate this preferred source
> port to the sender.

Yes, we toyed with this a little. Communicating the hash to remote
is far less trivial. The thing that made me switch to the PSP idea
is that modern NICs can RSS on the flow label. Which is nice for
non-steering capable clients, and it conflicts with pre-computing.
Maybe the benefit is not big enough to matter.

Do you have any practical experience deploying reverse RSS?
Maybe I shied away from it too quickly..

> > This patch set implements exactly that using the optional PSP
> > Virtualization Cookie field. The PSP standard doesn't have much
> > to say about this field:
> > 
> >  Virtualization Cookie - 64b
> >  An optional field, present if and only if V is set.
> >  It may contain a Virtual Network Identifier (VNI) or other data,
> >  as defined by the implementation.  
> 
> If using the PSP option space, no need to (ab)use the VC:
> 
> "When the Hdr Ext Len is greater than 1, a Virtualization Cookie
> and/or other header extension fields may be present.  The presence of
> a Virtualization Cookie is determined by the state of the V bit.  For
> example, given Hdr Ext Len of 3, when V bit is set, there is an 8B VC
> after the IV, and another 8B extension header after the VC.  The
> format of other header extension fields is determined by the
> applications and is opaque to the PSP hardware. "
> 
> Right now all use besides VC is opaque to the device.
> 
> For use-cases that should be interoperable across vendors, we should
> probably define a standard option space, with well defined options.
> 
> In a manner that is cheap to parse at high rate, so no arbitrary order
> variable length headers.

TBH I don't see the need for this at all. VC is well defined, and fed
into TCAMs. IMHO classifying the use of the VC as VNI vs steering tag
can be left entirely to SW / association state. The non-V options
should remain completely opaque to the HW IMHO.
