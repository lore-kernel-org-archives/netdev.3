Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794193715;
	b=SU6mm+jxObtGcXBY5wEdn2x+oKSI5q6TFHSupVBhE7oTu5HLbhffcL8FvlyOQq/1bYkf
	 sk69CTcgfRkJtcBTnRwWpNkhTIq8nyOmdRl+vO11IoOC/rVJK3TYK8CiUx2+yGZT11Ny7
	 NpAeKI+endTaemnVfKha9gZoGwXgncg2wNIUrNHB8LO+NsAygKYlL2Yg5O0bI770BfVsu
	 YmQu574gHQw0NjUqo5pSTJRKv3rHhJ7Iht17U8cev8tLolRE5ntUvX2UT4usV0MfKMv+k
	 00d6pbsH3aADmcopwrj31wXspOPdN3R3Uf48GGrnluqMQtrYhNcCyn0Ons64XQlu2pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794193715;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=0sZDYHfCBUrE7G/AgueE+PrG6dEwDPLCmAlQ7vBMuvM=;
	b=fT+wgMg0TFsGfqIx0Kpfg+6xJ/h+aloER6pW0JWi0f9+TzXRfNLPQWsshhMF3CXfdRaq
	 lP7kF6v+MzFm+gBAj00BBFcKJzjiSHX7GP73Jbf9lmYdnbZKibouGk+SO2vgYLfDCAZH8
	 gV+HYd/ewh6QJOIJJmcDU1xlQZolB1ZWJy/KjXwVMIAMFjZMfWAk+JMXSyg9pAlevYePM
	 mLm4bZ4d+zT7vPeF1ZFEAQtukqy9z6E0pX2pGCAFg5l4DG7IitLLxEDIH4IAoxCN+HWgR
	 VoDbI2Pe/gzHD1aj4uF74O0UWOlqQi7XEDnm4YY1s8os01DA8cwtNmcVRvwlDN2PRRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=pt7WhZXe;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43153606A320
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 03:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43153606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=pt7WhZXe
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b0d09df973so294392a91.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 19:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794193714; x=1794798514; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0sZDYHfCBUrE7G/AgueE+PrG6dEwDPLCmAlQ7vBMuvM=;
        b=pt7WhZXeywLb/bcQV2nL6QpkS6JEXGU1cssautcEf6mWoJC18Gr54ooaweb+t1ZFIE
         ghCjULBymeJWwH+qHK0m1Spx+TGMO7fWA2VEegBq5iws/+OKiAROe4ChxlkcrC6TXsu7
         WT97TK8qLmt/p895r9JSxv3Qdcu1UKN5ZdMtLrmiwjFTBHBNa29uUxZ1SUXJBuWNMrem
         RXbIrgMJILoskHstKp8XhrNVuesrbsywHykYMIn3llw5DKc5SzjrQxZfDAE6Cz8XyXbl
         ihhd2u7ePq5vCeNgxuVZd2bAObcHZa59CgKxl4MwoUuiC9m1mxyFHKyrMSC5UyvM1KFB
         PHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794193714; x=1794798514;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0sZDYHfCBUrE7G/AgueE+PrG6dEwDPLCmAlQ7vBMuvM=;
        b=xl+spi34SpN6tEYp7ZpcXt0ZOK9stc+aV20hFpt0mXs49CIGXmblkFRqJsAEAZwDGT
         26e+LMyDQXoZAjAXmiIZmG2E+kRSrlsayNQQFueNABn8UdQnmU9sZvhGdkThaui4JtVH
         mJ9NRLAKlpx2+MOHd8miE6pxD7ujkVglCnWrj9O3uyzH5dnnPvUiTRGz6L0Rupq9Jzmw
         DEuGMrfJN0wT6S0fDwwYqAr3pmYaE6xgZk796fw9vaDdHwX76Qqwci3tJD5dM+ZTpoYE
         cQ81W28wuDkpUTDMclep/Zb/Bf6CS7uf6Ems0YdvcmteVXboDlHHBg5ygF/T0tBASOqO
         +yUg==
X-Forwarded-Encrypted: i=1; AL+hErF2smc0ZUHpbW+jBh2wmWmGVtgxpJWd6jFGR54RTEJhRS8zIbRwQnM+o8vSajdjy7loYZgdZuY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9U5MSpfXhRz1FcbAD7xq02zRfjALjW/vigQsulENShlVDTAvXd
	xNmrDFc8PZTvcx1UQSlALOiWfefOmeM5ppQ94QARWsKK9rLHjJ2i5MTE5S9RNZb0kU0=
X-Gm-Gg: AYBFou0jGdQYD1yHVAhBt7biaxQ6eK32n5HP/TPK8rgWLmZwZcIV4R/JyDa7KamM/dn
	RZqIqHU25q4+iHQ/RMUsDyMjUnWIM/OsfKoaWqKhGgkkYfItEpYUFVymCV9ZZN6CV4VpBxqETB/
	HjhIeLct3til1DLFu7prHXhR+MuwSUsVtvkljHPIG4O+BkmM6fFzJSlCcR4D7hkoxM2NEbgzayp
	Cap7rkXOM00RJFiLlHik5nEGTpinJU917ze5yjhnSNCvmnUyLaJoYGrwdIDuq/suhLPM/fG3DBx
	LYwhEREZ1fhKSkMhSN3jOKCZ05IUDi3pYMNpcl+B0eXlE4tzSadU7f6cN0RRtOVigiIbp/3mu5i
	9sU4RJKSlJarWXSuKz59pLL96SKG1R+u9CKxqRgKLR2Ilf6rHZkWQC5DzXuQIY5+kTUaolpkLee
	xUZG0fA1LXWql9ypQfm7u/DKP+dqIGGrOl6tNiWfrO/hZwhXVR0JgNYobNDIXdRw1FGFzbV/Hbg
	CBm5IRZ4YTfe1Adw5BhH7sgnI2MC55ULt1pCcLlrJXdxvwU/uEZVAjBZzAcET1qfTvD1PgDIDkW
	38t0V2QBDIvM+CYNq+aYG6EPRfElkWV1jv4l5U3mU9kclEbdJ0qCYKUxbbDZi858UKGj8/tO
X-Received: by 2002:a17:90b:2d87:b0:3a0:9c9d:eb18 with SMTP id 98e67ed59e1d1-3b12d479035mr2604915a91.54.1794193714581;
        Sun, 08 Nov 2026 19:08:34 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1032b8c55sm5027795a91.2.2026.11.08.19.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 19:08:33 -0800 (PST)
Date: Sun, 8 Nov 2026 19:08:31 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Tianyi Gao <tianyi@cloudflare.com>, netdev@vger.kernel.org, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@kernel.org>, "David S. Miller" <davem@davemloft.net>, Simon
 Horman <horms@kernel.org>, David Keogh <dkeogh@amazon.com>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, David
 Woodhouse <dwmw2@infradead.org>, Dragos Tatulea <dtatulea@nvidia.com>,
 Nimrod Oren <noren@nvidia.com>, Alasdair McWilliam
 <alasdair@mcwilliam.dev>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Magnus Karlsson <magnus.karlsson@intel.com>, David Ahern
 <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Alexei Starovoitov
 <ast@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Donald Hunter
 <donald.hunter@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Jonathan
 Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan
 <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Breno Leitao
 <leitao@debian.org>, =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5l?=
 =?UTF-8?B?c2Vu?= <ast@fiberby.net>, Danielle Ratson <danieller@nvidia.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, bpf@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@cloudflare.com, nh-open-source@amazon.com
Subject: Re: [PATCH net-next 1/8] net: add tx_extra_headroom and
 LL_ALLOC_SPACE()
Message-ID: <20261108190831.3f991a13@phoenix.local>
In-Reply-To: <willemdebruijn.kernel.2c6a653eb65fa@gmail.com>
References: <cover.1794020868.git.tianyi@cloudflare.com>
	<e90e748e0aefa7cbe1c2b31b8c7902ccf135c3f2.1794020868.git.tianyi@cloudflare.com>
	<willemdebruijn.kernel.1d64e7848503b@gmail.com>
	<20261107182526.69543-1-tianyi@cloudflare.com>
	<willemdebruijn.kernel.2c6a653eb65fa@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 08 Nov 2026 10:13:03 -0500
Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:

> Tianyi Gao wrote:
> > On Sat, Nov 07, 2026 at 09:51:07AM -0500, Willem de Bruijn wrote:  
> > > Tianyi Gao wrote:  
> > > > From: David Keogh <dkeogh@amazon.com>
> > > >
> > > > Add a tx_extra_headroom field to struct net_device for that purpose,  
> > >
> > > Main high level concern is just adding an extra field. What's next,
> > > do we need to add a field extra_extra_headroom?  
> > 
> > Thanks for the review.
> > 
> > A user needs more room either in every packet or only in new skbs.
> > needed_headroom covers the first case and tx_extra_headroom the
> > second. I do not see a third case.
> > 
> > needed_headroom does not only set the headroom of new skbs. It is also
> > the minimum that ip_finish_output2() and ip_forward() require of
> > existing skbs. Raising it for new skbs also raises that minimum. With
> > XDP on a veth peer and needed_headroom raised to 256, throughput drops
> > by 2.8% to 5.8% for local TCP and by 4.0% to 20.8% for forwarded
> > traffic. The cover letter has the detailed analysis. veth also cannot
> > set needed_headroom from user space today.
> > 
> > pahole on x86_64 (defconfig, net/core/dev.o) shows that the field fills
> > the 2-byte hole after needed_headroom, so struct net_device does not
> > grow:
> > 
> > before:
> > 	unsigned short             needed_headroom;      /*    60     2 */
> > 	/* XXX 2 bytes hole, try to pack */
> > 	/* size: 2688, cachelines: 42, members: 187 */
> > 
> > after:
> > 	unsigned short             needed_headroom;      /*    60     2 */
> > 	unsigned short             tx_extra_headroom;    /*    62     2 */
> > 	/* size: 2688, cachelines: 42, members: 188 */  
> 
> Thanks.
> 
> Pushing back on another design choice: the UAPI change. That both cannot be
> undone, and is fragile and laborious, requiring manual admin arithmetic.


I agree with Willem. This is heading the wrong direction.


The more wordy AI analysis is from the iproute2 patch side:


Network configuration should not require pre-guessing this value. To set
it correctly an administrator must know which TC egress programs are
attached, how many bytes each pushes, and whether XDP is attached on the
veth peer. That is a kernel-internal sizing decision being pushed out to
user space, where the information is not reliably available. Worse, it
goes stale silently: attach another encap action or move the peer to a
different netns, and the value that was right at "ip link add" time is
now wrong with nothing reporting it.

The reply that a stale value only costs performance is true but does not
rescue the design. The entire purpose of the field is performance. A
setting that quietly stops delivering the benefit it exists for is one
operators carry indefinitely without knowing whether it still helps.
Failing quietly in the only dimension the knob was added for is the cost,
not a mitigation.

Since the motivating case is XDP, the mechanism should let the XDP program
ask for the padding it needs, rather than making the operator translate
the program's requirement into a device setting by hand. XDP already
guarantees XDP_PACKET_HEADROOM to its programs. The requirement is known
to the kernel, in the right units, at the moment of attach. Propagating it
from the attach point beats an administrator's arithmetic and cannot go
stale, because detach undoes it.

Your own reply already works this out:

> - XDP on a veth peer: veth_xdp_set() and generic_xdp_install() can
>   increase the headroom of the peer to XDP_PACKET_HEADROOM on attach
>   and reset it on detach.

That is the mechanism, and it needs no uapi, no operator arithmetic, and
no stale state. I would rather see it implemented for the cases it covers
than add a permanent uapi that removes the incentive to do so.

To be clear on what I am not asking for: this is not auto-tuning. Your
objections to auto-tuning are good ones. The kmalloc-2048 to kmalloc-4096
cliff being crossed without anyone deciding to is a real problem, and the
reset-on-detach bookkeeping across namespaces is real work. Attach-time
propagation is a different thing: a known requirement, declared at a known
point, with a natural reset.

On the argument that program-side declaration is itself new uapi, and that
the labeled device is often not the device the skb was allocated on:
granted for the general TC egress case. It does not apply to the
attach-time propagation above, which is in-kernel plumbing rather than
uapi.

Which leaves the genuinely hard case, the one you describe at Cloudflare: a
service in a netns sends through a veth pair, the host forwards to the
uplink, and a TC egress program there encapsulates, after ip_rcv_core()
has orphaned the skb so the allocating device cannot be identified. If
that is the real residue, make it the problem being solved and argue for
the narrowest mechanism that solves it. As posted, the series leads with
cases that in-kernel propagation handles and uses them to justify an
interface sized for the case it does not.



