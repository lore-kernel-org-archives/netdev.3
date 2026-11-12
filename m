Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794471102;
	b=OB7Yx4r8EITDb5zW5/O5u3c1Eqw5ALGfxLGsyMz9j0nmKTBG+gbZbIFI7T9r0EZjlgii
	 qNXTFtwVxyfVC9S6x06FF/1nRbCuSqBAnWJEqGWJ5ZDN+3H1THO4tPz8djCZLOG+1uI7A
	 hXUB6wHvwLW/BetT5xaYwqSUGPOUtfW6nBNQFwoe5KoOth5oZGtsKJDkysipclkRBsGDy
	 awinoMlsV98v47k90FoqwiScSS0H4COmIebwZ8pKLxvt85cfkztBFLLv7CioaM3Nbqxoh
	 GNrkMXUrYtsaazZF9L9783ZWcE7NjTW5IhzBDDmjya2MFDeQFVsRu4qWB+UE9+eDzMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794471102;
	h=DMARC-Filter:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=1edyD5N1J8EN3b69dNiB9A5qFAQtafbY1ICw7qjdkS0=;
	b=KsN+nsgSeT3E3Jsx9IE23iSfh7Hs4KnkuYqQM8am2W9Oz6wigVHpZdpYeJCCVnvuOg2s
	 Drjouwcfbn0r+6w6m4Cf8kwry7ET5kR1dJTq3ihR7es6tP+X89Dbp6nFqv4xaNQs4Cl/o
	 QpQN5WGCmFztWZlhx1+AuoWPypGCIIEopMCnmpbYww9fjy+1arevj7tBxfDo+t9Z2tHNs
	 VNm8EG19BMq9JKLp7qSqRpkse63//2oPJ1wv1sOvdLnpnsC5PmyeNbv8Mdx0PkOFQmFtn
	 jc30w6UauRJkKrCZZHZWRM3qr6lhXiuzEtNJNd6fZSyPn4Ar3/KXj3Eu1BTQ3woLASw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b="D/f90ToT";
	arc=none smtp.remote-ip=117.135.210.7
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8B2606A339;
	Thu, 12 Nov 2026 08:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D8B2606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=D/f90ToT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=1edyD5N1J8EN3b69dNiB9A5qFAQtafbY1ICw7qjdkS0=;
	b=D/f90ToT2XVcnqcAcmE4YR526ESKRs1jkhOxCxK5XiB9FTs/GSBnPo42WODGfK
	yQbNdHs0dKYKKcMK91GmmYS3VuK+h1wN7E8oLJ1aIh1N0m4CokO0Zyw/2sDFoJM+
	arGm671TGGrTWrBJMDJ0RFV8ChmgQVof+zJWD2moLdSlk=
Message-ID: <19495076-dd9d-4e39-900f-30d47aabf8df@126.com>
Date: Thu, 12 Nov 2026 16:09:45 +0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: ethtool: phy: warn about a phydev with no
 link topology
To: netdev-bot+sinfo@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew@lunn.ch, kuba@kernel.org,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com,
 horms@kernel.org, devnexen@gmail.com, sdf@fomichev.me,
 2022090917019@std.uestc.edu.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>
References: <20261112075517.3904496-1-xiaolinkui@126.com>
 <179447052068.2168702.1832622139543878794@kernel.org>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <179447052068.2168702.1832622139543878794@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3N6hJdPVqvWnTDA--.16124S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr43WFWrur17Wr1fXrWUurg_yoW8Wry8pF
	Wjga95AF98Jr1xtF1kZw40v3W0yrnxGayUWr1YgrW5Z3Z8K3W8KF4aqr45J398Gr9av3W0
	qrWUt3W5ZFyqvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uuv38UUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqQtHHmr1dEumEAAA3t

Hi,

On 2026/11/12 16:02, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>   - How the issue was discovered, e.g. hit in production, hit during
>     development, syzbot report, manual code inspection, LLM or static
>     analysis tool scan.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
Thanks for the reminder. The issue was found during an audit of
net/ethtool/ assisted by an LLM (Codex). The audit went through every
place that dereferences dev->link_topo, and phy_prepare_data() stood out
as the only one that does not cope with a missing topology. Following
that back led to the IBM EMAC driver assigning ndev->phydev by hand on
its fixed-link path, bypassing phy_attach_direct().

I verified the Fixes: commit (9dd2ad5e92b9) and both call paths (doit
and dump) by reading the code. The issue was not hit in production: no
in-tree DTS pairs "ibm,emac" with "fixed-link", so it is latent in
mainline and only out-of-tree users such as the Netgear WNDAP620 would
hit it.

As you suggested, I am not reposting the series for this. If a v3 is
needed for other reasons, I will fold this into the commit messages.

Thanks,
Linkui

