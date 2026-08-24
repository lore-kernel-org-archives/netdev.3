Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B533AA4F1;
	Mon, 24 Aug 2026 12:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574431; cv=none; b=li5xGZUTHLYDPtnU955venwHaj8nXtYWJhD4ro7JFDdCLBbW95vFnOVl4lycK625g5HFvfprrkPh4smtjGwiDoxG0Sw2BEOCXv0qJ4OLy59OXnGJsq22H7t8JyFAsB3jky40EQKR2IUCb8D7iFfge2RBPBhfRYQFwrOLSkYqcoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574431; c=relaxed/simple;
	bh=bAut4G7jqv6Ba5BlqX5Diq9ileAQKm02OyD/Y1R5N0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nc+RGLT39AhniYwO9VWsDiJq7HTYpH3JYFa2ln4i8mWZO4hgPWYLYb8olSJx8M0Uhh2fS9CGGTgLqZ0x5/RFo6gnEP5AvgWT8LpoNkLwDQvbPdQTXFOXvLDLWhazuWFsLm+85mWPuDa3rtRHf3E1SuHWe6M318DH3yUOV+CTkGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8xlhEQQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8xlhEQQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F801F00A3A;
	Mon, 24 Aug 2026 12:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787574430;
	bh=2KppF6BsjrXoiiB1CDGyfYgfQe2GP4/90TbLnIHY5fA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f8xlhEQQdyuxOTGOxIMPFkQV1ICcWlMUDMXn56ev/JQAOo0t1NNfbfx4vWu8Rfibc
	 CEsHmj60y7cvRmzsWxc0ubhdZkuRtot8GWZmKVEPWvTEKBmcuneu0HCA18tdXE2qlI
	 sjoFYatmewNjAiv7e77Yuoz7gfXp3vkL+lpgVv8Wwm9TcmvUf0a/PoBBOfqQQDOk2Q
	 PpTGPkpu2fbj39cdj/yE+fT/W4Csgf4ua9xHh+O10QzwblxiP2B/RDAJH+p2pmht9K
	 ah5cZMGo/zKdVFEo+EnegJ41l+kylEUfNoMD8vB/5kzSW3zvRzlMKifGn7nIsYhsTf
	 ool1ki6masarA==
Date: Mon, 24 Aug 2026 13:27:06 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?SsOpcsOpbXk=?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: gue: reject invalid REMCSUM offsets
Message-ID: <20260824122706.GR265046@horms.kernel.org>
References: <20260820220210.3122690-2-Jeremy.Jean@oss.cyber.gouv.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260820220210.3122690-2-Jeremy.Jean@oss.cyber.gouv.fr>

On Thu, Aug 20, 2026 at 10:02:10PM +0000, Jérémy Jean wrote:
> The REMCSUM option carries an absolute checksum start and checksum field
> offset. gue_remcsum() passes them to skb_remcsum_process(), whose
> partial path stores offset - start in the u16 skb->csum_offset. If
> offset is less than start, this underflows (for example, 1/0 becomes
> 0xffff).
> 
> A forwarded packet can retain CHECKSUM_PARTIAL and reach a
> NETIF_F_HW_CSUM driver which trusts the metadata, leading
> skb_copy_and_csum_dev() to write two bytes about 64 KiB beyond the
> destination buffer.
> 
> Reject reversed tuples in both normal and GRO receive paths.
> 
> Fixes: fe881ef11cf0 ("gue: Use checksum partial with remote checksum offload")
> Assisted-by: Codex:gpt-5
> Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>

Reviewed-by: Simon Horman <horms@kernel.org>

