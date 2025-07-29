Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E4728C00D
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 11:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753787245; cv=none; b=UrfPJ636aS4VF/j8EW/XIi9Fetd5zBrdZTfVYf9cmtKuVe6OCxTMCJmNZGV7vz0YBDjKtk0l8B4T6EUwaPqMEig0osqhVdvWD27HmOgGWXquCZ2QENercTK7qa7PewRNKfamp+MmnK3NmSYjItK4ktEc/EtbndMujQDlYodBEi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753787245; c=relaxed/simple;
	bh=Ul64qMUWvkwWIUV1hYwGXvbP+mQwEUWqDHTkBDPUItk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLb7ZuL0pKaKxDT4bPgCEX5iAZ2bO0rmGTay3y4VAh6jj8vLWNnhSNdAvTOIE75610+q7sLR3M4yzU580QIj8tZlZpO2Tep4iCM0SJVhf2vtvh+i9r9sjmiPitx3V0auEZiUS2KhKsEfXEwP2VaMmXmHhInqc76VShHDtf7M7uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=c0iii36c; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="c0iii36c"
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 12CF42117647; Tue, 29 Jul 2025 04:07:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 12CF42117647
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1753787244;
	bh=MADhVPdCxV08h7NFPon+oWUssRf8/Vli2Ljysy6/VSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c0iii36cBabjg2try6IDU4l2s2gwpTzMd1ziHK7PLVFiC3MlK/z+U0711F3b37fH7
	 j6VaiI9MaS4m9M13ASnpv21b+symgjKjJLfd1QlyGRDyLwOSt2tZQeva8wu2Vt+HWJ
	 AozwTNEJWLc0rHjFYdc92Ynk7uUi8jjk78/rSjsE=
Date: Tue, 29 Jul 2025 04:07:24 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dsahern@gmail.com, netdev@vger.kernel.org, haiyangz@microsoft.com,
	shradhagupta@linux.microsoft.com, ssengar@microsoft.com,
	ernis@microsoft.com
Subject: Re: [PATCH iproute2-next] iproute2: Add 'netshaper' command to 'ip
 link' for netdev shaping
Message-ID: <20250729110724.GA15902@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1753694099-14792-1-git-send-email-ernis@linux.microsoft.com>
 <20250728111303.301f61f2@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728111303.301f61f2@hermes.local>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Jul 28, 2025 at 11:13:03AM -0700, Stephen Hemminger wrote:
> On Mon, 28 Jul 2025 02:14:59 -0700
> Erni Sri Satya Vennela <ernis@linux.microsoft.com> wrote:
> 
> > +
> > +static void print_netshaper_attrs(struct nlmsghdr *answer)
> > +{
> > +	struct genlmsghdr *ghdr = NLMSG_DATA(answer);
> > +	int len = answer->nlmsg_len - NLMSG_LENGTH(GENL_HDRLEN);
> > +	struct rtattr *tb[NET_SHAPER_A_MAX + 1] = {};
> > +	__u32 speed_bps, speed_mbps;
> > +	int ifindex;
> > +
> > +	parse_rtattr(tb, NET_SHAPER_A_MAX, (struct rtattr *)((char *)ghdr + GENL_HDRLEN), len);
> > +
> > +	for (int i = 1; i <= NET_SHAPER_A_MAX; ++i) {
> > +		if (!tb[i])
> > +			continue;
> > +		switch (i) {
> > +		case NET_SHAPER_A_BW_MAX:
> > +		speed_bps = rta_getattr_u32(tb[i]);
> > +		speed_mbps = (speed_bps / 1000000);
> > +		print_uint(PRINT_ANY, "speed", "Current speed (Mbps): %u\n", speed_mbps);
> > +		break;
> > +		case NET_SHAPER_A_IFINDEX:
> > +		ifindex = rta_getattr_u32(tb[i]);
> > +		print_string(PRINT_ANY, "dev", "Device Name: %s\n", ll_index_to_name(ifindex));
> 
> The display in print is supposed to correlate with command line args.
> Use color for devices if possible.
Thankyou for the pointers Stephen. I will make sure to integrate this in
the next version.
> 
> > +		break;
> > +		default:
> > +		break;
> > +		}
> > +	}
> > +}
> 
> Indentation is a mess.
> 
> Iproute2 uses kernel coding style.
> Suggest using a tool like clang-format to fix.
Sure, I'll use this tool to correct issues with indentation.
Thankyou.
