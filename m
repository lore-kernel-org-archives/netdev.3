Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793354611;
	b=shByYd1QfB16Za0GvK+iue6LFKExS+3ZFgB9bpTfeaaDCk8h+kh4wHWPQ3V3Hw0l/ZQo
	 K02h2Yik5IRmBAtvAE4BSuN3g+2O7hQTK/QLDFZsBieQfsZtnnB5L/1GGv0LQo3RMBd4Z
	 naYto/hHM+gSgOf9fcLMrzH+tXVF4Whye8n7FcQ+TfFdTMgjtRsDkiuvD1AGLCgXZAlw2
	 khGoSFJND3sR6FOwP3iGAPPtN/YhfDSVw91TR7H7ospY2H7HjxYhYiPd/4L3STtknrsmC
	 Knk0iSs91wom8VD+Gh7yQ1uT8WkZlzLxdDu/6HwHCFrc052oFi3M6fZVagcfmfzE0KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793354611;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Flag:X-Spam-Level:
	 X-Spamd-Result:X-Spam-Score;
	bh=6Rd7CdAoOvbEN+kBCXHPSQkR/i8uksa042I7q/RWLPo=;
	b=VppLScMtqrc2ZYl7LLClU7ZWviYUiBgh4YyDk7so2oWURofkhg7E68CxU8i4f5rrWGgU
	 2jOaG3G52dy9hygKZIheIk6GUqDlNKxFPHcm2+b+vT63QXGXYWLe4xwce7Ffp3yVtTuxI
	 LcJ5+olLNByDGHgaRapCjT1vG2VdrzQl1UevafkMZXEaJOlaKOUl7plWSZVP8liuIYQDe
	 xDO+UU1b/gJ0ZrqVy4iKB2vTIR9Jm7oI2Ilw+AjtxkYxfJ2H3giOuTzVHtrY2w7pK22nJ
	 6AR/ACIwu8zdi5cIL9OKWoKNueJcmI+yBB0+tJyrEEhb+CyGU/WMscsbgmrLaN80/ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=apeqzSYB;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=FeWyCS0N;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=LpcGbO4y;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=e5yfQuAZ;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BC4606A31C;
	Fri, 30 Oct 2026 10:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32BC4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=apeqzSYB;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=FeWyCS0N;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=LpcGbO4y;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=e5yfQuAZ
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2E1431F74B;
	Fri, 30 Oct 2026 10:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793354609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Rd7CdAoOvbEN+kBCXHPSQkR/i8uksa042I7q/RWLPo=;
	b=apeqzSYBaZ1k61RSnG3YhlJXNkZUGUwehF36+DZ8SoeyXUtbtJUj7juUR0OqxZLY5Hbhr+
	DbFU3mBTIPtoytTUgHJEfGENdGYHedQGjMi9D37+8O6YcrygNP62AvtcwGjoVpp7XJaQm2
	rgToNRoyYroy1APaYF2ML5D3zh0e9jg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793354609;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Rd7CdAoOvbEN+kBCXHPSQkR/i8uksa042I7q/RWLPo=;
	b=FeWyCS0NsfydJ5lQO2Ze8Uly27yf3H3JMtqUN09SG5UNhwM2AKorh0Gn+Q6LGWEjP+jM6a
	KNRKLMlwRYyhcmDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793354608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Rd7CdAoOvbEN+kBCXHPSQkR/i8uksa042I7q/RWLPo=;
	b=LpcGbO4y5/u6LbDO6RC9J3vxa9aDDbucFK4wP8d0vSvRHMzFoGszj/5Lm3s5dFy2tX+2Ql
	2VCn/a2wKO08mGBFbsF482sQC50d1CGiw6XKEioGL9SNpY4IWqf5G0zP/+ZJrjk2OfFt+t
	r2sfNruBgQc3Vhsrfe81xCjTWTpqZxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793354608;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Rd7CdAoOvbEN+kBCXHPSQkR/i8uksa042I7q/RWLPo=;
	b=e5yfQuAZWmeMw9IGf0Zwyq/B99hYRowPveIUIgPdI9lCuFNHQgJaNXGM3weyWTPCcXbHiK
	EgWYiPxP1EF67dBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93E1313419;
	Fri, 30 Oct 2026 10:03:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n4EiGW9r5GrlAQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 30 Oct 2026 10:03:27 +0000
Message-ID: <53223bf8-8871-4b24-82c4-a86a26b50904@suse.de>
Date: Fri, 30 Oct 2026 11:02:16 +0100
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
Subject: Re: [PATCH nf-next v2] netfilter: nft_flow_offload: do not offload
 multicast
To: Koral Ilgun <koralilgun@gmail.com>, netfilter-devel@vger.kernel.org
Cc: pablo@netfilter.org, fw@strlen.de, phil@nwl.cc, coreteam@netfilter.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Koral Ilgun <koral.ilgun@adtran.com>
References: <20261029220144.2474139-1-koralilgun@gmail.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20261029220144.2474139-1-koralilgun@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[adtran.com:email,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.29

On 10/29/26 11:01 PM, Koral Ilgun wrote:
> From: Koral Ilgun <koral.ilgun@adtran.com>
> 
> A flow holds one output per direction, which it resolves when it is
> added. The outputs of a multicast route change when listeners join
> or leave. So a multicast flow in the flowtable continues to send to
> the output that it resolved, also after the last listener left, and
> the counters of the multicast routing stop.
> 
> A ruleset can keep multicast out with a match before the flow
> offload statement. Without one, IPv4 multicast stays out of the
> flowtable only because the reverse route lookup in nft_flow_route()
> refuses a multicast source address. The IPv6 route lookup has no such
> check, so IPv6 multicast that ip6mr forwards goes into the flowtable.
> 
> Skip a multicast destination for both families in the flow offload
> expression itself, so that the result no longer depends on the
> ruleset or on the route lookup.
> 
> Signed-off-by: Koral Ilgun <koral.ilgun@adtran.com>

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

Thanks!
