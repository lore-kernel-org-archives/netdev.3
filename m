Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D8134DB59;
	Mon, 23 Feb 2026 09:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771840488; cv=none; b=kJe/efoLxUtD7dE1k0CbWsCSIk4gVapTPU+L4lcqYajSiZinJ/ZK7tQZBmLa9N4X7TEF/x66jeWnoE3Cm6aDyunTql+1xp059q6R44qkXLQm384HbWOEo8/RJs7+DAbBsaNXghYg7hUNiFfhRnODE/y+OgyLTIjqp5hBltfxC+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771840488; c=relaxed/simple;
	bh=nNTeQyC3JCJ4lTlpuCPtdMUYRBv478ziaQfoSfmX8Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EzgBnpiLzvOqwdnFpjcbAF6pgn/d2V+tQXe9TAVvgrf7HuNmgndgekKoRxxtUe6oBKx4x6MtYBtKIPXGyvhdiAJ5QmQmBDniVvS/EMbubVv/wmIceX6xXCo7SkXOBdyAsBmhRoKf0ja0PJxg8aBT9x0LpAErPPaPu4Pb2skAt9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id C672D47E96;
	Mon, 23 Feb 2026 10:54:37 +0100 (CET)
Date: Mon, 23 Feb 2026 10:54:37 +0100
From: Gabriel Goller <g.goller@proxmox.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] docs: net: document neigh gc_interval and
 gc_stale_time sysctls
Message-ID: <sesyijabmxi5muc2rn432wrk4pxy24jri4i3y7fulrttv735wu@spf2houzg3sb>
Mail-Followup-To: Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260219162200.510325-1-g.goller@proxmox.com>
 <20260220164344.68ab2a6a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260220164344.68ab2a6a@kernel.org>
User-Agent: NeoMutt/20241002-35-39f9a6
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1771840463196

On 20.02.2026 16:43, Jakub Kicinski wrote:
> On Thu, 19 Feb 2026 17:21:58 +0100 Gabriel Goller wrote:
> > +neigh/default/gc_interval - INTEGER
> > +	How often the garbage collector for neighbor entries should run. This
> > +	value applies to the entire table, not individual entries.
> > +
> > +	Default: 30 seconds
> 
> AI suggests that this value is not actually currently used
> in our implementation. I can't find any use either, TBH.
> It's read and can be written but it's seemingly not used for anything.

You're right, I'll remove this section.

> > +neigh/default/gc_stale_time - INTEGER
> > +	Determines how long a neighbor entry can remain unused before it is
> > +	considered stale and eligible for garbage collection. Entries that have
> > +	not been used for longer than this time will be removed by the garbage
> > +	collector, unless they have active references, are marked as PERMANENT,
> > +	or carry the NTF_EXT_LEARNED or NTF_EXT_VALIDATED flag.
> > +
> > +	Default: 60 seconds
> 
> AI adds:
> 
>   Important caveat: This check is only reached when total_entries >= gc_thresh1
>   (line 1000-1001). Below that threshold, the periodic GC skips the scan
>   entirely.
> 
> If true I think we should mention that ?

Yes this is true -- I'll mention this in the description.

Thanks for the review!


