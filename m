Received: from mta0.migadu.com (out-137.mta0.migadu.com [91.218.175.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141A5389443
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 08:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787126790; cv=none; b=dH7eEu4JrYqy0OneMTGSrHLXUZ8i/GcHX8lBQwO69j1SMavfIbkwodFdwL9ezTFKEJXxUlB88NuoLJbyGqwNJI3u4kUmZqC58L1lAEaH3TeQtPGFxmiIfHWPA8ExQE7GXf7+FgKYSkUFPiusX24dzmWqWf3PsEai/4XSKyT9M5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787126790; c=relaxed/simple;
	bh=ZVoLcGIlNUjAyiuW+SvLaK/Ldal5OT9m0wA1S2PKRk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXeHQuiAp3YO5ey0o9svkSnKa6cx6hxz/HJ3/uLTR4beBIAHxj/4e/EiAQY5xZRfO/M/fa5Q88kASqyLc9SkyeiVZp/Ve/vquhuierKN46olDeC+fCPUEzOy0JmxcCaBLeW5mX/4EpyTts1AohJoNJpjuQ/xamQaLNhe2ZGoy7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jo4fu5Jr; arc=none smtp.client-ip=91.218.175.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jo4fu5Jr"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ZVoLcGIlNUjAyiuW+SvLaK/Ldal5OT9m0wA1S2PKRk4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787126784; v=1; x=1787731584;
 b=jo4fu5JrMHa4JBkNXyoGD+FwonQgE1Wlk8kpKpVFIuLCdLaqmmDnRxz76eXw1laJAXhRiU/I
 gTv4zQlCO+H+5xf1SGD+FU7eqR1W/dWpusNX7JYuqgNwT0Nk85HpFx2PpRZw85OLzOxRvgD2P38
 +XlMKPdEkL41Jf9StDHf6jr4=
X-Envelope-To: netdev@vger.kernel.org
Received: from fedora (216.236.36.151)
	by smtp.migadu.com with ESMTPS id 073c4fa40ea8497c;
	Wed, 19 Aug 2026 08:06:23 +0000
X-Migadu-Flow: FLOW_OUT
Date: Wed, 19 Aug 2026 16:06:15 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>,
	syzbot <syzbot+f2f6312ad1b5a0bfe316@syzkaller.appspotmail.com>,
	davem@davemloft.net, horms@kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in rtmsg_ifinfo_build_skb
Message-ID: <aoVj9yxiWrZXJ9X8@fedora>
References: <6a7f3555.dbb3a75c.20434b.0005.GAE@google.com>
 <CANn89iLye45x8mhXm5-rcttmCqjDKEEXR70o9jJeFy0kOp0zbQ@mail.gmail.com>
 <an-hOd_nV-xUqpUq@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an-hOd_nV-xUqpUq@krikkit>

Hi Sabrina,

Wish you all well.

On Sat, Aug 15, 2026 at 01:14:01AM +0200, Sabrina Dubroca wrote:
> > diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
> > index ee0e2eb7dbc61c1affe4b0203337f2fdaeaa031c..0844f551d3be696bad72a8322fa4ea1bf9ccf105
> > 100644
> > --- a/drivers/net/macsec.c
> > +++ b/drivers/net/macsec.c
> > @@ -4402,7 +4402,7 @@ static int macsec_fill_info(struct sk_buff *skb,
> >                 csid = secy->xpn ? MACSEC_CIPHER_ID_GCM_AES_XPN_256 :
> > MACSEC_CIPHER_ID_GCM_AES_256;
> >                 break;
> >         default:
> > -               goto nla_put_failure;
> > +               return 0;
> >         }
> 
> It's not possible to create a macsec device with a key length other
> than those 2, but it's true that returning -EMSGSIZE in this case is
> not correct (-EINVAL + DEBUG_NET_WARN_ON_ONCE I guess).
> 
> The real problem is that we register the netdev before private data
> has been fully initialized (macsec_newlink calls register_netdevice,
> then macsec_add_dev), so we end up reaching fill_info before key_len
> has been set.
> 
> So I think we should run macsec_add_dev before registering (and maybe
> move those allocs to ndo_init), and possibly macsec_changelink_common
> too. Setting the sci was intentionally done late, so this bit should
> stay where it is.

IIRC, we talked about this issue some time ago, but I forgot to fix it.

Sorry, I also have to leave it to you to fix it. But feel free to tell me
if you are too busy.

Best Regards
Hangbin
