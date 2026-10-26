Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793020677;
	b=N5Me1xYBCgjPJHcLyU2tWWcBUKQG4q5dPAGcikMjpLcBfNMWlS8Tn8T/owHW1R/qJ4Rl
	 YnpnDyxy2M7rlxbk58SeJofHzyfaF1umOree7LwllVEmnIOGPu7ihiQxiciNUw0VdRRua
	 4sT4cgDy+ow+MrwCNeF6MMPzPwzafn9jHHDdOuvzLGlsa7Fm5cRss0aC5vt5803v2iL3j
	 CUEUAH7si0uieYVUoPadKNPj1wdUVAauCJ6GiP7NSrAJG7lxm4FBLwJO74K6a6QjwlX5t
	 lzKMvEyV6y3Y+RNSua/s7ao8VGPC392KpokQLZtWjCTVAIgwwvBHWCsFHFtCa5leMFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793020677;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=DYT+M8Uk3V4J/Z/IRTpt1/3J1OMBoKzUZaILDtmUKj8=;
	b=bl/lvsnG31HyhT71eR/zxSGC1HrpJXt1uo569mFq1ALxsEuCP6evk/bqLHv6MjCs9QS9
	 wo3oCqH2FK37uRUE4yo7KkKCp9pLAaok0uejo2JNbquJcWxw3vYnSRhZMCsKgEgT7XRJQ
	 B1nBIKh3+ArVtXvmrExpwGJXG+CosmcttMy0oalZWYoKwQyp2VPxElQ1KhiEkm5llL1Kd
	 3jDZ2xFMac/JXcGRRKWynkl0mXz2DIPExzEDF8jPewpuficI9R86SpItPN8ofOWFRR7pT
	 y5le2yy4Bvpl6OSjQJ3AnMBqSyx35EoG5AlD7SObRb7ho8jOSKPt8ixLIkS9TvQzDdw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UJfTyFeO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3421606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 13:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3421606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UJfTyFeO
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1931ff67a29so541844c88.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 06:17:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793020676; cv=none;
        d=google.com; s=arc-20260327;
        b=MYJR9EX0TS1CdKe+JOsPvuVhEFqh/XwV8rmhW/k5ttWFA3GqaURH/lg1uUembTSjtV
         PI8NXSFdhf35GVYDI46b0tYlpiRrtjjBKt1hDPAE1zYFGvBGL7mkXDTmIiOq6nLG8yjR
         7LvgQdjSzQ+AeneBWBXkspt+Trvx/Y36+OK4rFGcIll1MQduYMKpvLUoDe/g39UVjzIe
         hqlMhhyk5YXSmRqP6KqkVdqD0Xav0C4Uet2HyF4iEQC6FFc79iVrEq1nZJ6kgRK9xx+p
         lUX4R9+SDdlRmymMvIw1MexO8223D0L8cd2HmiBxCJQj2t6KQuFJkNKZj6RkgcgVbyZY
         p9lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DYT+M8Uk3V4J/Z/IRTpt1/3J1OMBoKzUZaILDtmUKj8=;
        fh=B/ICBbiv9nJIkTFgU1OGzzT+89TTndWmv2MVvRsTQ3Q=;
        b=To6d9GMcQiz4NZLNSdusU/8859+/I4UJupQAjHhrxtzBJgBVUQMsyNQcaL6mhPLpSR
         HlZ0MEySwWgolVKGeV98lwbKVFE2EnQGZbD/DOVVjoPs5nsSGdVZKk7Ewiw6A2nyyGE3
         +gsmzTC2wLcdAKziYXMzuS8nVhFBe550wE5rmSjL3G1KsDus4uh2al9ZTO6CCgi/hGTg
         fdRlp38Cnc/2A41HKAVNxAWIr+ZndIyHLpIPXTSCUykUvmQpSuKZ6R+ZQO8pA41ZHicm
         TB3DG6461CoNAEAp7UmLTkWYmZW1y44o/jJTEgeOdVDIDfheMyZYhtvSFGNMPrRCn+BF
         Ih/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793020676; x=1793625476; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DYT+M8Uk3V4J/Z/IRTpt1/3J1OMBoKzUZaILDtmUKj8=;
        b=UJfTyFeOcWoDIfrWhSY6D3p0AiPZ93DBhEDONKiIzMoxI+M0o8/j/hfUdZhYrOd7Sn
         mOf2Ur5rwjvPIGHAbM+wfiuhLwI4Uv0yUGGagErKu06bftpHNfhPh+vSUrtX9Mduulmf
         DQH7dDpOup7QZv8HTsOBvGlFUnYcRGyvFi47lRexe+PfxQyLgpFThI4vblZeS2neFz0c
         r7M6DmMi9D44fngfHRWFtq3WfeFpGFEzGfYfzEGvGl6XWiwI/btqUyg+Pd4njNQ7+Izk
         cfmSd55J3YUWv0Oujj8BNIK93MR8Lx5ymtj1E7dljeF55Q+25PBfnxVgpWqECa7d5zcF
         CAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793020676; x=1793625476;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DYT+M8Uk3V4J/Z/IRTpt1/3J1OMBoKzUZaILDtmUKj8=;
        b=UC2W5f9f8UXd2nCzHTYzKsZW7J3WZWqLmolJWNODjfnaYe70sYJhBsEY8aU8IMBHX1
         iq83AjApe1E44RefU1va5Lg22p6PqUBWnwcVVcOsXHJih1J33nRvvEcHLqJSmo/1QjNd
         +/gB5U39ZGRTQHyreq1ziz6r2UxZC8cPapBCiXXrUpfOi99nAoBTSmXSzW8IVMCdI4vp
         k6es2nEJY46JuIdd33tZndxzzI/RK4OWHsk9VtlCisZJKEdRHeLoRn2ViKoz4cPmWV5b
         8s9o316SkRHQnZDSIWsAdzYNn7oEZn4syYEJtF/Oro0pP9haaRQvE9IQxhVeYQw9UWU/
         uSHA==
X-Gm-Message-State: AFq9FYI/BjQDSQgDPGLaLMfKUMQXxHFKTGAMc65L3EP8GanatiSF4hLl
	JNW7h8iOSvVPFJFipqjxCBiCVNtc8XifkCI5jIHzJZJALdhG4ZRZuSQA5jQWvLz6ljAytBTrLRm
	fWZlAt2DPdc2GSvddAUSsaJ77r4jzQdQ=
X-Gm-Gg: AYBFou1U7yxFyq+tF9l5QzNBhYwv/zJ0vvuZfo589/55glDL8aNn48Jiy6LHjctEFHf
	SI2gV3sujMPh7xoq04Rw7WEx/YvVRk+iJm+hiC3qELd0XVKo0hnTg7ylBzz63M8MeJ4SLvgxCZZ
	XHWSAl+p/ZnFfAsn2ed32Z9293qvDhxp4W7orHzVpIQFHikpj1WFsYwRa/kMZo0yzeOVARVO5n7
	K3AFAfXaxoJXxO1dBGMuuS8n2SlHxC7TyJbOCj5sgjoSUEgMMyXph+YrhfzI7V39pJlv/Az9eMJ
	2VBbChWHW6nWzLBiINy2EDvmui2bVQr1Kw3J3ieGKNdA+SYk+FiAFDuE60IC3uTgTHNs7t0txqm
	fZYhfw1c2tePd3jJchWjoikR18wmM+nROuV+D
X-Received: by 2002:a05:7022:eb57:10b0:163:bee9:b250 with SMTP id
 a92af1059eb24-1993552efefmr11334057c88.22.1793020675923; Mon, 26 Oct 2026
 06:17:55 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022103821.89552-1-timur.stukan.linux@gmail.com> <179301247732.3134.17655450292431284280@kernel.org>
In-Reply-To: <179301247732.3134.17655450292431284280@kernel.org>
From: Timur Stukan <timur.stukan.linux@gmail.com>
Date: Mon, 26 Oct 2026 15:17:44 +0200
X-Gm-Features: AclHuK-1hlvBxosq_mvLsNV9n4GELniIQBfNw9d2o2fMPYw7Z_WcD_egBiiNOVw
Message-ID: <CAF+_u5B+=MVHLJ6QyDn4BO2cLM8PTYsbvAAwOHumQGDqPK+a7w@mail.gmail.com>
Subject: Re: [PATCH net] bonding: fix missing down path on speed/duplex
 failure after FAIL->UP
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, liuhangbin@gmail.com, fmancera@suse.de, 
	jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Oct 2026 at 13:01, <netdev-bot+sashiko@kernel.org> wrote:
> > +                             if (slave->link_prev_state == BOND_LINK_FAIL) {
> > +                                     if (bond_miimon_slave_down(bond, slave))
> > +                                             do_failover = true;
> > +                                     continue;
> > +                             }
>
> [Severity: Medium]
> In 802.3ad mode, does BOND_LINK_FAIL always mean the slave is still in use?

Good catch. No, BOND_LINK_FAIL does not always mean that slave is
still in use, bond_miimon_inspect() follows that rule but
bond_slave_netdev_event() does not.

That is not new behaviour though, before this patch it could be reproduced also:

Take the 802.3ad slave in BOND_LINK_DOWN with a non-zero last_link_up.
Its carrier comes back and is lost again before miimon brings the
slave up and driver still reports unknown speed/duplex, so the
bond_slave_netdev_event() sets slave as FAIL, then in
bond_miimon_inspect() carrier check fails and link_new_state is
proposed as DOWN and bond_miimon_commit() runs the slave through the
full down path although it is already down, with the same
consequences: link_failure_count incremented, a notify event, dmesg
print and a call to bond_3ad_handle_link_change(). This patch only
adds another way into that path, when the carrier is up but
speed/duplex are still invalid.

The root cause is the notifier using the last_link_up rather than the
current link state. I can fix that with a separate patch that sets
FAIL only for a slave that is currently UP or FAIL, either as part of
this series or as a follow-up.

Anyway, I'll wait for Jay's feedback on the overall approach before sending v2.

pw-bot: cr
