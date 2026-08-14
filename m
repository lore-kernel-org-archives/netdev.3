Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B0C4756AE
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786714861; cv=none; b=atIMJE2vt80YgcXBtjheDVfUgsv870aYC3hlsXF0aP4UiZDppaVY0qxbTf9jC/JJ5uIgttb3eeo943JQF48hlLMgQnG8oHTYKfbidqzgzlcLgP4PZSjpMXApgK1juGyyKnm8U5TSQbmX9PhuJElWH4jhUetANwJIkGSt/1aD5rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786714861; c=relaxed/simple;
	bh=JkQvWpFwSOZKWVG+WH5duwlUXn/Y9HyIKHJMUQwI0oo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GTkVNSeNGFrrKH1kX/OWHs8q/uTdgea0ny7oCtKXshPIJaa9T2oDBkdCobbSeA1h5raiVYk1liitYs3I3NpzLue6/D1ArCxWr5Fo1I1GWCgAv1EqIzaMFzm+3n8vsnYFNw+t3ojG4wfAn/aFfSr9yvrsRI91che3D+yHcaxTwxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=ajhKR4xN; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="ajhKR4xN"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47f703a9e5dso507846f8f.0
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 06:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1786714853; x=1787319653; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0z3jl2/6dMWRcJpwvE9PJlP3Jj8vGqtXbKS9xUQqdtY=;
        b=ajhKR4xNPVYfP5nyQs9BbDmS0FyJk8beJOOVib8g7TEi5lHSTid8qPfkW7T4t358ns
         ZPpXR+/EPPT0MYPkwQ4ZO3oWrfTfk3qig3dMzcjB0Y5szz/pHVN1gCaFCwHeiZC4BPmx
         qMrUom6dNvRaw5Ih3XE49mp4wfMnneJywEsHasXScL0IrZYpPE8VKj5q66rJNyrj3Xjp
         AOe0yzDjnb2CNAGDDKHjIt5vR1BYI4MWlHx3wqTlQ7MnQAKxr22Y4I2ozjygOQRouGjH
         sGkZqgQ9qtbLtPICCDTxQWn/sylnyJRwxFrHyAa+/CmZ/ht2bvXho3Ge1HY3UMHn5qB9
         N3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786714853; x=1787319653;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0z3jl2/6dMWRcJpwvE9PJlP3Jj8vGqtXbKS9xUQqdtY=;
        b=MWWspOOJipJEfs5KFZCf5lL/cbeACvM1kKxKgAmbXxGSAJUM5TFwuyJ7AY7HT9QLjw
         YAoF1IZwEuncia6qGfrd+R/1rrNLt3Xrip8abMU0NOPRfT/EsPr0UlblEiG1j8CK0cS+
         Bw7/tkAFFRjFj7JRuvh9fIEC43EFyVy+hYYDKXa80ZxP+Yd/8Sts5ahqhzilPlDLCLr3
         GxT6jBvq6ZjJoeibf6DBsFy+/nyZGYtQSa/dCsC+XUAQenjstvEb7N0LW2FznUHKUTBx
         WPnChZmoUqdxyHIzEH9qQVX7qKaSD1ci8Q14UhsGUUMszmCjo9/c5CQzwdlp1WXw62+u
         fqcA==
X-Forwarded-Encrypted: i=1; AHgh+RoV9Nzci9EqgqSxfAZV+aQgawT4zCLRrGWCIo7FxNQyraN2bG+vKWX3mJhE8E0fUh1CvxRyEO0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2PdcVytOGvMJSzffM8eEbzaVCXixCxu7blq+V7s/pSH28B946
	DstAHOIKBvbPgBepS1Xuzd72tVz+jEL4a/8meJZF4OJ/vSG02c3PI8vwM21qxlWoCnY=
X-Gm-Gg: AR+sD13hU8hD4CwsZ65j4KC3OVmAqwR6YSHnvde9Lu+wvORc1zkndTKoWLvGOPn1sWy
	4wgiX8oyjsrTOKsfOt6nhb791FZpojvNE01sxdk0QACkyRd3THRCDrRB95BNAX5hdIVB7GOaEcz
	h2aTcWq1EKgAqHytyQcMCcdp1bYoLkQfizMdSNw0A0wKDPeuc60gZ8KdJo8g3WVwLGPNZXeo2al
	uoUU/2enPDdysmdQUn9O4dLUGK/StExHA3bdjxPAZFanEBj3Yals4XG9SiXBX8mFcCFWvN4VS11
	p3JLtzJ3KlBEec3YNiknsASq76a3ivG0V9bQCHoYp3gJcjM+Ww+iT71hcNNpd2zffI9dP2I/rKx
	69UjerCZjzz7RvUfEzH7SNyKoC0kErNAnLC7Z7wY5c+gj12nG4TM7kFVjhxf6CyH1xS8xQY+XKZ
	rc4M5lkbxs/kmdrUSgiiAIzIuma5NKA4BWzG1w7oIIZvpcnT4Y8ffMEsVHqEHjdRL9nxb+cce7Q
	U0SS/nmE9Hfj5pODT0i/kD9sevulOeCQz965xAhEfPM1nSxHK1L55LP/I2zi01AMPJjL5KlHKeE
	pn71sE4tRlw=
X-Received: by 2002:adf:e004:0:20b0:481:f343:82ac with SMTP id ffacd0b85a97d-481f343836dmr3136587f8f.12.1786714853109;
        Fri, 14 Aug 2026 06:40:53 -0700 (PDT)
Received: from smtpclient.apple (ip-88-212-19-42.antik.sk. [88.212.19.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f1ffffdsm7873539f8f.2.2026.08.14.06.40.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Aug 2026 06:40:52 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH net 1/2] openvswitch: only skb_tx_error() a packet we are
 about to drop
From: Norbert Szetei <norbert@doyensec.com>
In-Reply-To: <00a1176a-8b1f-47b1-9376-349cd08ad313@ovn.org>
Date: Fri, 14 Aug 2026 15:40:40 +0200
Cc: Willem de Bruijn <willemb@google.com>,
 Pavel Begunkov <asml.silence@gmail.com>,
 netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Kuan-Ting Chen <h3xrabbit@gmail.com>,
 dev@openvswitch.org,
 linux-kernel@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C8A61CEF-FB36-47FA-A38C-5BA0968D6CAA@doyensec.com>
References: <8063260C-05C9-4997-B9B6-2135063C4858@doyensec.com>
 <C35992B1-7740-4886-94FF-F85DE8B0106F@doyensec.com>
 <b20650c2-1adb-4902-b2b1-9bca91b95dec@ovn.org>
 <741D4072-50EE-437B-BFC3-CDFE94C93F8A@doyensec.com>
 <00a1176a-8b1f-47b1-9376-349cd08ad313@ovn.org>
To: Ilya Maximets <i.maximets@ovn.org>
X-Mailer: Apple Mail (2.3826.700.81.1.4)

> On Aug 14, 2026, at 14:31, Ilya Maximets <i.maximets@ovn.org> wrote:
>=20
> On 8/14/26 1:01 PM, Norbert Szetei wrote:
>> Thanks for the review. Sashiko flagged
>=20
> Hmm.  I do not see any reports in either of the instances.  Do you =
have a link?

=
https://sashiko.dev/#/patchset/C35992B1-7740-4886-94FF-F85DE8B0106F@doyens=
ec.com

>> that the moved call may still be
>> reachable through the RECIRC action, and I confirmed dynamically that =
it is.
>> With 1/2 applied, a flow matching recirc_id 0 exactly, with actions
>> RECIRC(1), OUTPUT(0) instead of USERSPACE(unbound), OUTPUT(0), =
reproduces
>> the same issue. So please hold off on 1/2.
>>=20
>> Moving the call to the "default" branch assumes that branch only sees =
a
>> packet the datapath owns. For a non-last OVS_ACTION_ATTR_RECIRC,
>> clone_execute() does
>>=20
>> skb =3D last ? skb : skb_clone(skb, GFP_ATOMIC);
>> ...
>> ovs_dp_process_packet(skb, clone);
>>=20
>> so a clone lands there while do_execute_actions() carries on with the
>> original. The clone shares skb_shinfo() exactly for the skbs this =
series is
>> about, since skb_clone() -> skb_orphan_frags() returns early on
>> SKBFL_DONT_ORPHAN and does not copy the frags - so settling the uarg
>> through the clone clears SKBFL_SHARED_FRAG for the skb still being
>> forwarded.
>=20
> AFAIU, operations on a cloned skb performed via proper skb helpers =
must
> not affect the original.  That's the whole point of the clone.  =
However,
> in this case indeed it looks like the skb_tx_copy() just modifies the
> shared info not checking if it is shared or not.  And this sounds like
> a bug in skb_tx_copy().
>=20
>>=20
>> Removing the call, as I originally suggested, does fix this in my =
testing.
>> If you would still rather keep it, how would you prefer to solve =
this?
>=20
> Just removing the call from openvswitch module doesn't solve the =
problem.
> Packet may enter OVS already cloned somewhere else in the stack, and =
at
> any other point in the kernel where skb_tx_copy() is called it may be
> operating on a clone of some other skb causing the exact same issue.  =
So,
> it needs to be addressed inside the skb_tx_copy() itself.
>=20
> On the other hand, reading the history of this function, it seems like =
it
> lost of its meaning with commit 1f8b977ab32d ("sock: enable =
MSG_ZEROCOPY")
> from Willem that changed it to just call skb_zcopy_clear(skb, true);  =
This
> changed the "false" signaling to "true".  So it doesn't even signal an =
error
> anymore.
>=20
> Later, in commit 753f1ca4e1e5 ("net: introduce managed frags =
infrastructure")
> Pavel added skb_zcopy_downgrade_managed(skb); call that takes extra =
frag
> references.  Though it seems pointless for an skb that must be freed =
right
> after.
>=20
> So, I'm not sure if this function is useful in general.  Feels like it =
is
> only harmful as it directly modifies shared data with no regards to =
clones.
>=20
> We have two options here:
>=20
> 1. Minimal fix: add something like skb_cloned() guard into =
skb_tx_copy().
>=20
> 2. Remove skb_tx_copy() entirely (all calls and the definition) as it
>   seems pointless after 1f8b977ab32d.

Thanks for digging out 1f8b977ab32d.

Option 2 sounds cleaner to me, though it touches tun, ovpn and =
nfnetlink_queue
as well. Option 1 would not cover the reported case on its own, since =
there is
no clone on the OVS_ACTION_ATTR_USERSPACE path, but it should work with =
this=20
patch 1/2.

Curious what the others think. I can write whichever you settle on.

N.

>=20
> Any thoughts?  Willem, Pavel, others?
>=20
>>=20
>> Thanks,
>> Norbert
>>=20
>>> On Aug 13, 2026, at 12:00, Ilya Maximets <i.maximets@ovn.org> wrote:
>>>=20
>>> On 8/13/26 7:47 AM, Norbert Szetei wrote:
>>>> queue_userspace_packet() borrows the packet skb -- it only copies =
it into
>>>> a private netlink message (user_skb) and does not own it; on return
>>>> do_execute_actions() keeps forwarding it through the flow's =
remaining
>>>> actions. Its error path nevertheless calls skb_tx_error(skb), which =
via
>>>> skb_zcopy_clear() does skb_shinfo(skb)->flags &=3D =
~SKBFL_ALL_ZEROCOPY,
>>>> stripping SKBFL_SHARED_FRAG from that live skb (skb_tx_error()'s =
kerneldoc
>>>> says "skb must be freed afterwards").
>>>>=20
>>>> For a MSG_ZEROCOPY skb carrying page-cache frags, SKBFL_SHARED_FRAG =
is
>>>> what makes esp_input() skb_cow_data() before in-place AEAD; once it =
is
>>>> stripped a later local ESP-in-UDP delivery decrypts in place over =
pages
>>>> the sender does not own -- an unprivileged page-cache write (the
>>>> "Fragnesia" primitive).
>>>> do_execute_actions() ignores output_userspace()'s return value, so =
any
>>>> action after a failed USERSPACE upcall inherits the stripped skb.
>>>>=20
>>>> Move the skb_tx_error() to the flow-miss drop path - the "default"
>>>> branch of ovs_dp_process_packet()'s switch(error), before =
kfree_skb().
>>>>=20
>>>> The call has been here since commit 36d5fe6a0007 ("core, nfqueue,
>>>> openvswitch: Orphan frags in skb_zerocopy and handle errors") but =
was
>>>> harmless until esp_input() began relying on SKBFL_SHARED_FRAG to =
gate
>>>> in-place decrypt; only then did stripping it on a still-forwarded =
skb
>>>> become a page-cache write primitive.
>>>>=20
>>>> Fixes: 36d5fe6a0007 ("core, nfqueue, openvswitch: Orphan frags in =
skb_zerocopy and handle errors")
>>>> Fixes: f4c50a4034e6 ("xfrm: esp: avoid in-place decrypt on shared =
skb frags")
>>>> Cc: stable@vger.kernel.org
>>>> Assisted-by: Claude:claude-opus-5
>>>> Signed-off-by: Norbert Szetei <norbert@doyensec.com>
>>>> ---
>>> Reviewed-by: Ilya Maximets <i.maximets@ovn.org>


