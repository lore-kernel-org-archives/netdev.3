Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793286694;
	b=FomRlpUN0Icy8/HK0JveDk9zQJb50EkSQNwKnil/oLrE55esYbQ/IBE+XK6FOzAXXZ/M
	 Nl6IrHDmst/Wx0+Dyhewp1FboHUVHdw99HInFqlhIYMatjvIGrEVUPNeOU7XuGXAbWorS
	 MADQlarCjl9aTQE9TIV5MXe3Ozj2dTCL/+tdo8wO5ZZ+r9IFqRkldH7blrMk8sAHMWTMm
	 nO7znO9BYs3pcaBOfCUmWlAaSBmDEtUm9I42V+IURQtnOu0MKxIoBSZjwLh5Qda8oNetW
	 ejrLSuYGl7NGd1lBYZRLn+AkvkCj9TZ/2hHDEQlZoo0N6iJpPxx/RrQrg3lBo016a5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793286694;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=yYGp7worVnCPGHf5o+Qio/3sLzdmXlqWp7TBfw5BhDM=;
	b=lrSxLMCLlo5NmHKEi3yR5AnoVZH1BIjk3X/E2vK4BlOAKfGRxI8gCxJXkx5V8PhKrsgD
	 pFP0krMUUi/dTCRh2d3t/1LYoQl/8hYKDzbTisYhGQOwgMG59nFtiCmohcCyq75mNT+sk
	 RGhcSoasdGiGGh2BlPAQscbv/iW+S4TS0Yin/gP9H1v1iM6+YmFJuikbETI7K1x6J7gMO
	 qMIHFbBvzfZ+Rwx8Tr7i9pVGfLKpVrovWssmm4vuHDOKdRvMPj0Z1GBsq5On2Wu9YgECn
	 mhvJtHfMs6Duo3oZ4T+Q7myslYTDBC2/YmIMjqMjF3yiTylMoNlZ/vtkI0iMoKKmiuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=DUZRJ0qS;
	arc=none smtp.remote-ip=209.85.222.53
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E4D606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 15:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41E4D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=DUZRJ0qS
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-98c6e050c5dso1212917241.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 08:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793286693; x=1793891493; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yYGp7worVnCPGHf5o+Qio/3sLzdmXlqWp7TBfw5BhDM=;
        b=DUZRJ0qSvCyOP/xODEp5vWmKnQn5e8gBR/46YShx6NhGxSOAC30g4PFOllDVz9oYGO
         Elrxt7oeWSiEPNR9OLdmKFP/4BR27zIGiVw58glwxoNGUfS8O761Z7BBanpriTfVu+7u
         o248J9bOQ376eOKsJCw34zl+CkNCTViBs8l8lcF1IVJ18z9WFNRrAEz+cZiavEsn0gFF
         pPKO58WUDoim9a8d5pdTSmQZby2sd1WDJHKrB3aXX7O4L59vrGxBLYYNAAWECb4vG70C
         B1mD9OOKH97TRUPoCigaIhp+CHWlsXOeetUmSGW4dL16IvIAT7Yq/QU6dQMdmZc00x8f
         Seaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793286693; x=1793891493;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yYGp7worVnCPGHf5o+Qio/3sLzdmXlqWp7TBfw5BhDM=;
        b=OGHuougsg/z30iyUsF9kYqYlvbFGBnPqUoHmFjmDte6RamTJFwMmFbiFxjudbBpmpT
         NFtO28NhEiSRtdr/Fzoe+dtVexAfdUQYxeY+rWWvsBhDsj+BY6nf1y0ETXIPQh4HwcxZ
         TstsL1V3uEdU9V0Prz/KR749euaXCNMd0t61OnetvFFpoclj2lR6PSxrAILs2pTsdWnH
         udXGmWFRNJdzw7SwL/M5k8N/E79ntO2vWiwIIaNSLLH1tyrso/9zuZzgttpFzO0l9CEs
         DAD3rkgIMMktqbXtcN0Et2qjaBrebjLHM1gQledJW2nfchcK0aq41GyWyhTFFggLj+6y
         SD2Q==
X-Forwarded-Encrypted: i=1; AKwUvBx0Yh6QB6BuGECNAu9PNlIwaTZJVNSNDFHQbu6/u/xWVKJ0CGmG0IRSymH4O5Ggtzk6G+p0LOg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKItUgReEMsEAu5wCnUsrsnaeoC39XCd7Ga5ADffLGhfzmvC+uX
	qS+wsA8ELY6clb5XZuTla2Pl3ksfngKTvZkWAUX2rnS9jQ3jpKu8menQb362b3EnICA=
X-Gm-Gg: AYBFou1PgCsW8KgjYtq8c/862mS2Q8oQQeWSQ+cHotKLbRE883txK9Rsfqir0un+kQj
	Gefm/KmeXqmwCNkG9fnT45wyr7CKP2NOzEpQa8AXtKU86JcD6pIkeBJ4HXwsz1gTfZ/XseT8SQl
	UDUXGLH/UhDyCehnu9aDXLegUMKPysyHf5LhQdwVTUqrPbL8aqZw7Vv9fugV7pCeBYvjS7zL+Yl
	OSEjUdXcxI66b41ciuainE6RcdTGnotbQpwpWBL+DTZPwhw02Aap1l39jyZGwkDPkzizHRumS5a
	zllqmSygp2RAVh8ygl3W84zi6hRDMgaQovYweFfBgWbmVWIZsJ5BGdOwxeSUFMjBsip8kPu8MPl
	hF7PwSzykJ5+y5YP0Nw3PA/jflQ0Qo6xlTccWq+psFJ2FvAXPzRehjQHXaVbJZQr3kOZ9QeveVf
	YZ9c5huFmbNBSKsW+cKN2MolV2eNnboqtEUOVxoOCskFaUSzH4f5FqR5f5z2FnXDBqrb/pqNmxr
	YRYjMq451QHTXQAUpnua0sKUW8uFFc9KHcfWvnmc7Ma24u45BTrJNvBS/7MPR/ZkhmN7505H1Jo
	84ZPr/xvb7+b6gI9Z32nq1L30S3StoqS1ZKQ95qZv9WovQ==
X-Received: by 2002:a05:6102:50a3:b0:7c3:2b19:6267 with SMTP id ada2fe7eead31-7d03a541d57mr2928287137.32.1793286693044;
        Thu, 29 Oct 2026 08:11:33 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca2904af7sm165316d6.14.2026.10.29.08.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 08:11:32 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net] net/mlx5e: Fix stalled channels with threaded NAPI
Date: Thu, 29 Oct 2026 15:15:00 +0000
Message-ID: <17932869000000.4.mlx5e-threaded-napi-stall@toxicpanda.com>
In-Reply-To: <1a26c186-bba5-40f9-8cd9-3967b2b268bf@nvidia.com>
References: <20261021-b4-mlx5e-threaded-napi-stall-v1-1-d719c17b3ec4@toxicpanda.com>
 <cd140948-317a-49d8-885e-0ded451195c6@nvidia.com>
 <17926738093796.1.mlx5e-threaded-napi-stall@toxicpanda.com>
 <bf7ecec5-8bf4-47b0-bbf5-6dc8fa4e64d4@nvidia.com>
 <1a26c186-bba5-40f9-8cd9-3967b2b268bf@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, Oct 29, 2026 at 02:52:06PM +0200, Tariq Toukan wrote:
> We confirmed it on the device, on ConnectX-6 Dx (the generation in your
> report) and on ConnectX-7: an arm raises an immediate event only when
> the CQ holds a CQE newer than the last reported event. A backlog the
> last event already reported raises nothing.

Thanks for checking that.

> Please hold your v2 until these are out, and rebase on top: your patch
> then stands as what it is, saving a complete-and-rearm cycle per budget
> with threaded NAPI.

Will do.  Please Cc me on them.  On top of your fix it is no longer a
fix, so v2 will drop the Fixes tag and go to net-next.

What changes in v2 besides that: the test moves into
mlx5e_channel_no_affinity_change(), as Jakub and Bjorn asked, and it
tests NAPI_STATE_SCHED_THREADED instead of NAPI_STATE_THREADED, so that
it follows who is polling and not the mode that was asked for.

> One request for the code comment when you reword it: today it reads as
> if arming never raises an event for pending CQEs, "only for a new
> completion".

The comment in v2 only says why the CPU of the NAPI thread tells
nothing about the interrupt's affinity, it no longer says anything
about arming.  The changelog will use your wording.

pw-bot: cr

Thanks,
Josef
