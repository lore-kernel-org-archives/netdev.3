Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AA747426A
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 19:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787946287; cv=pass; b=phG05b6pS13g6KCTDHuz5mfmlh3Fyq0nV90UJfwdWjZS/ljeBwn3kZWtSvKO3Vg7SRQgT/EFP9KlmQwvPChH9gqzRDsUn8FCBOmFGC6L9HS2w/dhh+DLHwklmO6ueR293yP6VV+7LSMIfKiYej+iRSUiki483JCgz130wMp44Q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787946287; c=relaxed/simple;
	bh=ezmawUeZfIihlnCZxaj/Y+NiA51zVoKGOvpMQNGYGWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XMEjvtpXYB6psxtSifBLeqoyLlfCz/fIdNTqt3+SMSKCvUAho3tbamqLBG26T3uu8p4kB0aUMstFBVZJZoNVQAvIWZzuN8XpoMxZklK7BoRVptGAH33QCZ4GT/3uXg949ciIcRMyt+817ybsOwFR7LUz5sdxHW8RszdJ487AsK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cxk63c6P; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cxk63c6P"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5218927884fso16266271cf.3
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 12:44:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787946282; cv=none;
        d=google.com; s=arc-20260327;
        b=XysYxyKHKJetnjkpBfoyXB+yabTsEYqBGjkYAqDevfuuJBaRxr6rs9ZSSy7zCjznU4
         yNaDCt7U9ZzUY+vspgcsnpwzS75bmaNw2sX+jej0DRc/KcKf62Pe/OygMbF8jW7/8iil
         Rk4m4eV7k6QwfMc4kaMZ2sj96BNuYTWihBfXRFoM8KjWzDx7TXFbdJl2SAMwA/EaGlz3
         rxwvfy2cqN4K02gL8d/duor4lAyiUaRVwhzGzv6Phlf/euEQwK0ok40OIrIoPAr/sv8x
         wVCYMRZswmVe8f6T6Ep9fwM/dW8rSXE4A0o408QdFbeh3OkiBp5QyTSvJS0oCT7DOfDs
         NXkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8AGJvH8Hm8+TZBsqJqj4crWZ4Cjkk8dFFd6elusTrto=;
        fh=mGj7soclz/85SeH14q6yY417Glib9COQC82wVtK9ZLg=;
        b=b4IZFebjeqcDFIPvKbuZXsnOzkV3H4UgxJbgvBjXaZEg7ZOEXlpH7/NBwQigzXSlJg
         BjMHTptD/yicbxubmeN9oujX+QH69Q48nsBsWF+cdxCJo7By5QZ+tiZKIUtsrSRqvN/Q
         5vsy0ttkUBUBTWH8JSbHyb2V5p0TECtrD3Z26lQOmk0tjFtfYXTuF+xtW+C7G/QI+o32
         nntg3N4MgIEs30rJ5dw8jsRZIspT6WzabKj+lZJ52qcsgHV2GtXqjSKPXvQIA8nZox2p
         l0M+sDoEcET5qaEBSpTUhtKnoKSomCUt5udVuzqKwDK5c/g96w+6tnqzTkormt1HdDXF
         sT7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787946282; x=1788551082; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8AGJvH8Hm8+TZBsqJqj4crWZ4Cjkk8dFFd6elusTrto=;
        b=Cxk63c6P7RL68gBF9lSpk+p5HFUGJUsqrQNDNbCk5Wg6eFhOmNiKNj0jSyicbB79bh
         8fZNviXGs15/a9ZXZZnjDVJpH1TKV8WKNAKBdReKTAERWVeFIqqiSrOJmxJ6Q4vNLn1N
         OBQGOpFraUBlP+4KIMThd1A6Ohyf62OiA9K1+xitX2g5IDt217Dpa7Q3iC2QUF4VSU8s
         jCb2PXhUrEttzoVg33IzZsayAzH3Vw3Wr0+FoZiTP99SmdHcgHkYDx6aN3UyCA5Fdi5U
         njVj5vPmfctwDKYWSKDMVadsVHMAezN44LR94WsX3SN4wejmpCAbdwIKcKUz4OvjSNeu
         E66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787946282; x=1788551082;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8AGJvH8Hm8+TZBsqJqj4crWZ4Cjkk8dFFd6elusTrto=;
        b=HYgI2D8n/gQoI8zLLCB7ouGDyd0p41xN3J4lE16MjvAR9n6E9Qdr8JmiIona39UBhj
         Dq0oaNHVam3RGlDRDaV1Lwqybfq3bmG0tncphyk3dG5wqBV1FTkoWIM6zvt9POX2pV9g
         Op58hcoQRIIcMZfn8VcsJPvsos1j9tXX2rhA9VLGDW4pAF8e7nhJ2qwE1wqN6Wkl16nT
         P9XtBPRhuGO0g6DO8Kdi+4xddvoPLOPmiY5CqepdN4oJrWyanWYnoOYTsUookIiBn76y
         Ja0wDlr1dZRzSi4mVq8m0B+0iNge4lGt8QnfljhVtDGRukTVnRuUdjIEXOccD60GKo9p
         Sr4g==
X-Forwarded-Encrypted: i=1; AHgh+RqAdCocnY9Ng+IbqZSkyNW2xT3MMkdSVpJimPbeGPLFVYHeODrAwBV4Zxp7OmCcPRXCn70WXts=@vger.kernel.org
X-Gm-Message-State: AFuF++mKCtMuzjEs8X5N5NvJpqiL99EKd94ETYpznNID8DYDFasvo6xB
	RLH9mr1cMlK/1fGR6RO/gyrd8Sf6kP+ePIloQgHsIdD3VQ07uq7Knu+sibMXHZWJaZ2cIJtKIiH
	7xuTspWwhOmBKAbXZWq7EcWp9p6FADdU=
X-Gm-Gg: AR+sD12BCFG1vAAre2XXs6uzP7UhiC17FjkccdDppdRfH6o2TfawP2WyBRgZSQfA70Z
	axs1I6yqHUOC6t/+MIcZCDbNNOGF/UwxMl/Mg+UGxCtnBPcF0YmvOymshjRyO24lIMlv8uTq+0+
	Wqv2mmTYY8NKp4KtQBVXjsZeBVaq8NlybgKbCpB2UOeSWaqeUTINy8+vIB1pXnKfscVD8PlEZI+
	yi4HzpP4YI7jxOrbKNORyBKiDTP4IGWKmZDOjNE/MvtVVfjwMtMwrdyAuBX971tkaohR+whBEpJ
	XjOkxHDOPxtJmDDZv5JHUFOhaN7k0wDYsxIKR7vXThv5
X-Received: by 2002:a05:622a:282:b0:52c:dde9:5cd5 with SMTP id
 d75a77b69052e-52fb95f3111mr109878031cf.21.1787946282501; Fri, 28 Aug 2026
 12:44:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1778378864.git.zylzyl2333@gmail.com> <7198fe2845c30c60c6b3833dd78cead8c5966931.1778378864.git.zylzyl2333@gmail.com>
 <e1f1b080-cfde-4ea4-b444-b64d43778b2f@blackwall.org> <9263d4c1-0c57-4926-930b-1d701e1f17db@blackwall.org>
 <CAAAOPT8mBxW9Fd9Sr=xWAb-fa4MUHCqKaQf86-DFNqaB9Xvgng@mail.gmail.com>
 <7ffc7cdc-8140-4ea2-b3bd-c86abe6e6cff@blackwall.org> <6c1c6972-c212-4139-b629-4603a8801cbb@blackwall.org>
In-Reply-To: <6c1c6972-c212-4139-b629-4603a8801cbb@blackwall.org>
From: Yuan Tan <yuantan098@gmail.com>
Date: Fri, 28 Aug 2026 12:44:31 -0700
X-Gm-Features: AcwNN1VGS688MXKgT72PsJhBCbqzV58ouNrjMVRWyL1dcGe6AdTVLI7Yz0t9dm8
Message-ID: <CAPuPA7KykYqE71P+7-7=1A50S1H3Ksi7ONk+kb_xR0Ep8HKBaw@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: bridge: cfm: use a per-bridge frame type
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Yilin Zhu <zylzyl2333@gmail.com>, Ren Wei <n05ec@lzu.edu.cn>, bridge@lists.linux.dev, 
	netdev@vger.kernel.org, idosch@nvidia.com, horatiu.vultur@microchip.com, 
	kuba@kernel.org, henrik.bjoernlund@microchip.com, yifanwucs@gmail.com, 
	tomapufckgml@gmail.com, bird@lzu.edu.cn, ronbogo@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 3:23=E2=80=AFAM Nikolay Aleksandrov <razor@blackwal=
l.org> wrote:
>
> On 12/05/2026 11:09, Nikolay Aleksandrov wrote:
> > On 12/05/2026 08:21, Yilin Zhu wrote:
> >> On Sun, 10 May 2026 at 04:40, Nikolay Aleksandrov <razor@blackwall.org=
> wrote:
> >>>
> >>> On 10/05/2026 13:05, Nikolay Aleksandrov wrote:
> >>>> On 10/05/2026 12:15, Ren Wei wrote:
> >>>>> From: Yilin Zhu <zylzyl2333@gmail.com>
> >>>>>
> >>>>> CFM registers a bridge frame handler when the first MEP is created =
and
> >>>>> unregisters it when the last MEP is deleted. The registered object =
also
> >>>>> contains the hlist_node used by the bridge-local frame_type_list.
> >>>>>
> >>>>> The CFM frame type is currently global, so enabling CFM on multiple
> >>>>> bridges links the same hlist_node into multiple bridge-local lists.=
 A
> >>>>> later unregister on one bridge can then operate on list state belon=
ging
> >>>>> to another bridge.
> >>>>>
> >>>>> Move the CFM frame type into struct net_bridge and register/unregis=
ter
> >>>>> the bridge-owned object. This keeps frame handler list membership l=
ocal
> >>>>> to the bridge while preserving the existing first-MEP/last-MEP life=
time.
> >>>>>
> >>>>> Fixes: dc32cbb3dbd7 ("bridge: cfm: Kernel space implementation of C=
FM. CCM
> >>>>> frame RX added.")
> >>>>> Cc: stable@kernel.org
> >>>>> Reported-by: Yuan Tan <yuantan098@gmail.com>
> >>>>> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> >>>>> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> >>>>> Reported-by: Xin Liu <bird@lzu.edu.cn>
> >>>>> Co-developed-by: Peihan Liu <ronbogo@outlook.com>
> >>>>> Signed-off-by: Peihan Liu <ronbogo@outlook.com>
> >>>>> Signed-off-by: Yilin Zhu <zylzyl2333@gmail.com>
> >>>>> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> >>>>> ---
> >>>>>    net/bridge/br_cfm.c     | 14 ++++++--------
> >>>>>    net/bridge/br_private.h | 18 +++++++++++-------
> >>>>>    2 files changed, 17 insertions(+), 15 deletions(-)
> >>>>>
> >>>>
> >>>> I think MRP suffers from the same bug, but I also think we can conta=
in the
> >>>> fix within the packet type structure instead of making the already h=
uge
> >>>> struct net_bridge even bigger. Also, linking a struct within net_bri=
dge
> >>>> to a list within the same net_bridge looks weird.
> >>>>
> >>>> IMO br_add_frame should take a type & a frame_handler, allocate a br=
_frame_type
> >>>> dynamically and link it, then br_del_frame should take a type instea=
d of a ptr
> >>>> and remove that frame type and free it with kfree_rcu. That would re=
quire
> >>>> br_add_frame return value to be checked in the respective cfm/mrp fu=
nctions.
> >>>> Warnings for already existing types on add or missing types on del s=
hould be
> >>>> added.
> >>>>
> >>>
> >>> Actually I have a better idea since these handlers can be added only =
once per
> >>> bridge, we can do away with a simple bitmask (e.g. use net_bridge's o=
ptions
> >>> which is in a Rx hot cache line) and even reduce net_bridge size whil=
e fixing
> >>> these bugs, and also remove a conditional from the fast-path when CFM=
/MRP are
> >>> not compiled in. Would you like me to prepare it or do you want to gi=
ve it a go?
> >>>
> >>
> >> Hi Nik,
> >>
> >> Thanks for the suggestion.
> >>
> >> I'll give it a go. IIUC, the idea is to remove the shared
> >> br_frame_type list entries for CFM/MRP, track their per-bridge enable
> >> state with bridge option bits, and dispatch the CFM/MRP handlers direc=
tly
> >> from the receive path when the corresponding EtherType and option bit
> >> match.
> >>
> >> I'll include MRP in v2.
> >>
> >> Thanks,
> >> Yilin
> >>
> >
> > Great, thank you. That should simplify the code and give us 8 bytes of =
Rx hot
> > cache line back. The important point is that there haven't been any new
> > handlers since these were added back in 2020, and also these are not
> > common, so making their impact on the fast-path as small as possible
> > while fixing the bug sounds good.
> >
> > A quick & dirty sketch of the fixes gives me:
> > 5 files changed, 47 insertions(+), 66 deletions(-)
> >
> > That can probably be improved (i.e. more deletions).
> >
> > Just please make sure that if CFM/MRP are not enabled in .config, they
> > would not affect the fast-path at all.
> >
> > Cheers,
> >   Nik
> >
>
> Hi Yilin,
> Are you still considering fixing these problems? A few months passed sinc=
e
> we last spoke.
>
> Cheers,
>   Nik
>
>

Hi Nik,

I=E2=80=99m very sorry for the long delay. Yilin has gone back to continue =
his
studies and unfortunately no longer has the time to finish this patch.

There was also an issue on my side in keeping track of this work, and
I failed to notice that the patch had been left without a follow-up
for so long. I apologize for that.

I can take over the patch, address the remaining feedback, and send a
new version. That said, I=E2=80=99m not sure whether it might actually be
easier for you to make the changes directly, if you are willing to do
so. I=E2=80=99ve heard from maintainers that reviewing and iterating on
someone else=E2=80=99s patch can sometimes take more effort than simply mak=
ing
the fix themselves, so I wanted to ask which approach you would
prefer.

If you would prefer to fix the issue directly, could you please
include the following tags?
Reported-by: zylzyl2333@gmail.com
Reported-by: vega@nebusec.ai

Otherwise, I=E2=80=99m happy to take over and prepare the next revision.
What would you prefer?

Best,
Yuan
