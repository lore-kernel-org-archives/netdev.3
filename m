Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6037A39CD16
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 19:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784575810; cv=none; b=asPnfXX2sYX1cRNN7Hy/WOtCEhuH/bwo/rgxjARlbWui4GXN04fc0Jd/Td5ngaIo4QOruh3VKGd15zZ21GXGgMfAPdAAgbwAsjHNU0KTxQCnXYSMAZh7pwWEG5pVb6P7S9xLb4W2SkKsYTYzVMJS0JtDXMGxNREhAgQ9WCmBAYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784575810; c=relaxed/simple;
	bh=rKMfwhrkWB1gMMAGP+WjhQxkdTfPEn8wwuAFqUPrn4Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y1sOfdhYcq5/JCGX/o+b0ofA7dIql5/EvTvNZCZI5VSnmZlgawSEWK3KhJ5aSmu5LaCDXyZzPTADfWhIxpoxy43xsxbJAjMmSWvBeiZyNkQwKSxGoUxLYpY47fzW2QWx2LXCr16ojjH9KOsbpzrhPOuCEaqVgidX7eyRi+vATl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X5ifbOLO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X5ifbOLO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784575808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sSwcE/5MaYFTkhfDGJhim6aINxhfl+eFANjBYAJQjQo=;
	b=X5ifbOLODrorFy7K5MlD+P1bw2l0FLUs/7SmlqVj2A7ngXVAKAMxqixBKzLxk4U3kHs/Js
	9f0sbZsoy6XPUv5mVq5PbCBGIuBlfByA8/dpG8ZjdgfCnpIevBPt+oszp5eXSNLh489zWY
	mqFnktdVp4UC7LgyGqvbsyccA4NjT6c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-7nz5vRbhPTKCErKgqzOUZA-1; Mon,
 20 Jul 2026 15:30:05 -0400
X-MC-Unique: 7nz5vRbhPTKCErKgqzOUZA-1
X-Mimecast-MFC-AGG-ID: 7nz5vRbhPTKCErKgqzOUZA_1784575803
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B23C6195FCE6;
	Mon, 20 Jul 2026 19:30:02 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.81.35])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6591D42A;
	Mon, 20 Jul 2026 19:30:00 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: andrew@lunn.ch
Cc: Yuan Tan <yuantan098@gmail.com>, Ren Wei <enjou1224z@gmail.com>,
 xuyuqiabc@gmail.com, netdev@vger.kernel.org, dev@openvswitch.org,
 echaudro@redhat.com, i.maximets@ovn.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, pshelar@ovn.org,
 yihung.wei@gmail.com, tonanli66@gmail.com
Subject: Re: [PATCH net 1/1] openvswitch: Fix CT limit teardown use-after-free
In-Reply-To: <c9a39c7f-cdad-4e8d-b516-b727806525a0@lunn.ch>
References: <cover.1784355642.git.xuyuqiabc@gmail.com>
 <aa8a1d8dcbac8a13dbdf077a642a66f4c5d81e4b.1784355642.git.xuyuqiabc@gmail.com>
 <c357f846-d42c-4b98-acc9-46b751818dca@lunn.ch>
 <0c037f98-f219-4851-9a06-e83b25ca0f7e@gmail.com>
 <c9a39c7f-cdad-4e8d-b516-b727806525a0@lunn.ch>
Date: Mon, 20 Jul 2026 15:29:59 -0400
Message-ID: <f7tmrvla288.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Andrew Lunn <andrew@lunn.ch> writes:

> On Sun, Jul 19, 2026 at 11:54:31PM -0700, Yuan Tan wrote:
> > 
> > On 7/19/26 19:52, Andrew Lunn wrote:
> > > On Mon, Jul 20, 2026 at 10:14:16AM +0800, Ren Wei wrote:
> > >> From: Yuqi Xu <xuyuqiabc@gmail.com>
> > >>
> > >> Packet processing uses CT limit state under RCU, while netns teardown
> > >> frees that state under ovs_mutex. The CT limit pointer was neither removed
> > >> from readers nor protected by a grace period, allowing packet processing to
> > >> dereference the freed state.
> > >>
> > >> Replace the pointer before freeing the CT limit state. Wait for in-flight
> > >> RCU readers before freeing its contents. Serialize CT limit netlink
> > >> operations with teardown for the full lifetime of their state accesses.
> > >>
> > >> Fixes: 11efd5cb04a1 ("openvswitch: Support conntrack zone limit")
> > >> Cc: stable@vger.kernel.org
> > >> Reported-by: Vega <vega@nebusec.ai>
> > > Is Vega a person?
> > 
> > Hi Andrew,
> > 
> > Thank you very much for your review!
> > For context, we had previously understood that using the tool name in
> > the Reported-by tag was acceptable, based on examples such as
> > Reported-by: AutonomousCodeSecurity@microsoft.com and Reported-by:
> > Anthropic.
> > 
> > https://lore.kernel.org/all/20260630171016.11c02dec@kernel.org/
> 
> https://docs.kernel.org/process/submitting-patches.html
> 
>   The Reported-by tag gives credit to people who find bugs and report
>   them and it hopefully inspires them to help us again in the
>   future. The tag is intended for bugs; please do not use it to credit
>   feature requests. The tag should be followed by a Closes: tag
>   pointing to the report, unless the report is not available on the
>   web.
> 
> If you believe this is out of date, please submit a patch with new
> text to this document.

It is common practice to accept syzbot reports as well, which look like:

    Reported-by: syzbot+36256deb69a588e9290e@syzkaller.appspotmail.com
    Closes: https://syzkaller.appspot.com/bug?extid=36256deb69a588e9290e

(see commit 539dfcf69105d8d3d4d677b71de6e5ede2e6dfa0 for example).

> I find it valuable being a person. It indicate somebody is bothered by
> the problem you are fixing. We see a lot theoretical bug fixes, which
> in practice nobody ever hit. I would prefer to spend my time reviewing
> real issues, not theoretical issues, and the Reported-by: is a quick
> indicator of this.

+1

In the case of syzbot reports, they are real actionable reports that we
can look at and address (and I agree with your sentiment of wanting to
focus on real issues).  They include the 'Closes:' tag as well, and a
reviewer can just visit the link and see the splat.  If there is a
report link that this Vega tool pushes, maybe that would be acceptable
since it's the way syzbot works as well.  It also makes sense to update
the documentation to reflect how it is used currently.

As for the v2, it would help my review to include some kind of
reproducer description - I usually try to experience OVS splats for
myself.

