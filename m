Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BE11C2AA
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 12:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784638645; cv=none; b=jb+YijiDrYFYYMmdlYDqrpCXFpm6UQLfIbgVDas2lA61A3ufXMsvQvBROx+c3iZOiozSselP4GPtd+fTnz3Wt3L6LumzQCpPcF2wvrR9SQTeyxuiiheJdG3qcEsL7abz2ShHt5Z2/s5+mVwT2jaBcjQ6AIeMa7k3ewa3kKCMWGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784638645; c=relaxed/simple;
	bh=5m/XgeHBI/Ggd2a2DuZydB/i3n/QK4nXobs3/vzxLkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dvxz8WCQIbaxz+zxtx6W36quvk4qq3Zg4r0qcWlEUfFlTyaaksyfFCzbdeLBx/H9mMCjqN7RZSoMfRLqo3Wns6CkarDYXvCV5W37CTm3drFDAwukXPXA7ksOH/X3dGAvLbf0AgYOTM+nr5uTGfnTibEnNJ9MXhvb50YoT4uX+z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5IGWVWx+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5IGWVWx+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=9K8/ys6YTjxxT/J3waBeTUjQbsDltfERYJhkbP8xs+Y=; b=5I
	GWVWx+OHiHIplpKMv7s4R3129E8bU+7OaZKnaPxW9+v2ly3Om+Y9t0fCj+UF9y8nSiLbicZJe8/Hj
	ylYEnrjGfF2BNNlQAJuHg+P1d8gYTnOlVqViY2YgUGtjbQ1y4xU+jAsntM7oMlySLeeCkvHDi6gJ5
	PZj0Odx4jsN5yFY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wmA29-00DR6l-8G; Tue, 21 Jul 2026 14:57:17 +0200
Date: Tue, 21 Jul 2026 14:57:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yuan Tan <yuantan098@gmail.com>
Cc: Aaron Conole <aconole@redhat.com>, Ren Wei <enjou1224z@gmail.com>,
	xuyuqiabc@gmail.com, netdev@vger.kernel.org, dev@openvswitch.org,
	echaudro@redhat.com, i.maximets@ovn.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	pshelar@ovn.org, yihung.wei@gmail.com, tonanli66@gmail.com
Subject: Re: [PATCH net 1/1] openvswitch: Fix CT limit teardown use-after-free
Message-ID: <18358c75-c072-4934-a4ca-32fc6a951ade@lunn.ch>
References: <cover.1784355642.git.xuyuqiabc@gmail.com>
 <aa8a1d8dcbac8a13dbdf077a642a66f4c5d81e4b.1784355642.git.xuyuqiabc@gmail.com>
 <c357f846-d42c-4b98-acc9-46b751818dca@lunn.ch>
 <0c037f98-f219-4851-9a06-e83b25ca0f7e@gmail.com>
 <c9a39c7f-cdad-4e8d-b516-b727806525a0@lunn.ch>
 <f7tmrvla288.fsf@redhat.com>
 <CAPuPA7KiuA9agAXbXFRA6-wRHe6=GPFu47wjc-MY-twHQXTF2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPuPA7KiuA9agAXbXFRA6-wRHe6=GPFu47wjc-MY-twHQXTF2w@mail.gmail.com>

On Mon, Jul 20, 2026 at 07:02:45PM -0700, Yuan Tan wrote:
> On Mon, Jul 20, 2026 at 12:30 PM Aaron Conole <aconole@redhat.com> wrote:
> >
> > Andrew Lunn <andrew@lunn.ch> writes:
> >
> > > On Sun, Jul 19, 2026 at 11:54:31PM -0700, Yuan Tan wrote:
> > > >
> > > > On 7/19/26 19:52, Andrew Lunn wrote:
> > > > > On Mon, Jul 20, 2026 at 10:14:16AM +0800, Ren Wei wrote:
> > > > >> From: Yuqi Xu <xuyuqiabc@gmail.com>

> > > >> Assisted-by: Codex:GPT-5.4
> > > >> Co-developed-by: Nan Li <tonanli66@gmail.com>
> > > >> Signed-off-by: Nan Li <tonanli66@gmail.com>
> > > >> Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
> > > >> Reviewed-by: Ren Wei <enjou1224z@gmail.com>
> > > > Please take a look at
> > > > https://docs.kernel.org/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
> > > > and the sections that follow. What is listed here does not follow the
> > > > rules.
> >
> > After reading this document, did you spot the second issues?
> >
> >       Andrew
> 
> Hi Andrew,
> 
> I have read through the document several times, but I am still not
> sure what you mean by the second issue. Could you please clarify which
> specific issue you are referring to?
> 
> At the moment, all of our patches are reviewed by Ren Wei before they
> are sent out. Are you referring to that Ren Wei is not included with a
> Signed-off-by tag? We did consider adding one, although I was
> concerned that including too many tags might make the commit message
> unnecessarily cluttered.

This patch has been submitted by you. There needs to be a
Signed-off-by from you last on the list.

   Any further SoBs (Signed-off-by:’s) following the author’s SoB are
   from people handling and transporting the patch, but were not
   involved in its development. SoB chains should reflect the real
   route a patch took as it was propagated to the maintainers and
   ultimately to Linus, with the first SoB entry signalling primary
   authorship of a single author.

	Andrew
