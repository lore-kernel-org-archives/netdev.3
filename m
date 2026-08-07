Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC733479885
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 13:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108623; cv=none; b=Rll/fvJO1g/Gv5q4x2Be8U1LXZ/YDuRLtW+Xe3rWEOigq3VVCKVdDLaWYUlAJu7vJVRLKmQKk5mclOQbuHnWX4nKDOciUldiVPEy+IfATRJ/NWdQlMpfaayJRpW88j9glOVQS7ozpa9bpSNghLgKYR7nBlcgEQVJuArrOGXQb4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108623; c=relaxed/simple;
	bh=/2E7sQuMTmfX5pqH0Qv+6Ma8jmJhb+CHCqKvTTEwOfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJl68UJu0Eu97E+5eW6L3N7jsu9kCx9iLS1I4Bi3/emMlONGdOGIvKSHLOqSZyvxNeiom+OP852s/ZPCdvMCt054wZYlqGSrdCikM9R9NIuSpaewXv2tfPQeOqrYxWzJxFKxDcpDHCbLwYQnpEdMXwmy6VLJnHjgC4hLEGmEaYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZdSfN7qM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZdSfN7qM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786108613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZpGvXHAw51KB03tCAmwbfWnx4faPy+B05yUewXeAM+k=;
	b=ZdSfN7qMkS0rrWaSTxa5m+tbRB0TyVXK7IL4oNkAMWTwkVXNKNh/tSLmsoteOY26A0VPGE
	D1JR5/rKC2NdFxpTwk2n58DRzAqW0nb1Ab51kOktZZozKjfCpv7DC6KXeLV6bk3I1b8xNQ
	K68DU8Q4kCrBHwoW0IV+i47hgAn5WuY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-6eML5XLFPz2VtqrH2-VKgg-1; Fri,
 07 Aug 2026 09:16:45 -0400
X-MC-Unique: 6eML5XLFPz2VtqrH2-VKgg-1
X-Mimecast-MFC-AGG-ID: 6eML5XLFPz2VtqrH2-VKgg_1786108603
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EAC4218002C4;
	Fri,  7 Aug 2026 13:16:42 +0000 (UTC)
Received: from thinkpad (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C944422;
	Fri,  7 Aug 2026 13:16:39 +0000 (UTC)
Date: Fri, 7 Aug 2026 15:16:36 +0200
From: Felix Maurer <fmaurer@redhat.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lukasz Majewski <lukma@denx.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>,
	syzbot+fbf74291c3b7e753b481@syzkaller.appspotmail.com,
	Xin Xie <xiexinet@gmail.com>
Subject: Re: [PATCH net] hsr: Avoid holding seqnr_lock while transmitting
 packets
Message-ID: <anXatDPkcVsCTB36@thinkpad>
References: <20260805-hsr_deadlock-v1-1-d8a6f06fc5a8@kylinos.cn>
 <20260807094325.GG51943@horms.kernel.org>
 <anXStphPD0z-ystm@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anXStphPD0z-ystm@fedora>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Hi Hangbin, hi Simon,

On Fri, Aug 07, 2026 at 08:42:30PM +0800, Hangbin Liu wrote:
> Hi Simon,
> On Fri, Aug 07, 2026 at 10:43:25AM +0100, Simon Horman wrote:
> [ ... ]
> > Simon says:
> >
> > I don't think the advice on how to annotate this is correct
> >
> > Tags trump freeform text, but Depends-on is a not a standard tag and as
> > such should not be used.
> >
> > I believe that the correct approach would be a tag like this:
> >
> >   Cc: <stable@vger.kernel.org> # aae9d6b616b5: hsr: Implement more robust duplicate discard for HSR
> >
> > Link: https://docs.kernel.org/process/stable-kernel-rules.html#option-1
>
> Thanks, I will update with this.

Thank you for the patch! Just to let you know, there is a patch
addressing the same thing in an in-flight patchset [1]. Unfortunately, I
didn't have a lot of time to review in the last weeks, so I'll just
leave this note here so you can coordinate if necessary :)

Thanks,
   Felix


[1]: https://lore.kernel.org/netdev/20260803222211.877-3-xiexinet@gmail.com/

