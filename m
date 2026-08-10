Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F304390C88
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 07:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786348654; cv=none; b=Vl6t2kWBaiCtM1jTHS+QLmHlAkmxuuptnkt/MWzIk+DdGHDsrBG7RhYQPZx4nfB4Ln1jlFLCtolOP7eNSAjyaZvrWVAQ+bz0F9B3UjiX3HhZd9ziTGZBYj12syO5U1yHwVPSzH9tzamAplmZAwZu817CeZedjZVAXyYTtDm6nRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786348654; c=relaxed/simple;
	bh=Q+/ssEHzlQooBUf9Jokz3i6r7X6BdwTkGLYLXKCuspQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGEO0l1P3dKuJ2FvyrP3Xrw+kdo5T0M0+64OT+MIay0xa2e3Z4QBomLIbG9iEviQdKm1uSqq+OT6hYXb2IBuB2QS07ts++MRpRkfMaTkmseW21nmaKV3UkfdMUNvP7JhiXyWAQuwMyyw3u9D3kRl1qshL5y/A9VHF/EFPk0VE5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hl8OiWAd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y+QOYfQl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hl8OiWAd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+QOYfQl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786348650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=faSl/UkvZhLeViesyQBAMKjmyR5NNeTyZ1tUwhC4yBU=;
	b=hl8OiWAdea8+i7CvrmQPrc4koWzz2ksDH4OZ+XqfEH/9GYNC6JmHXIYCx7uFTnZbGH3Oa4
	J4ZfcWp+CbCQ2pLTmccZHf+PBvoEAAHYKnHJElYlhnioY+2yzVbGAziHN1cpjpsfgwTuBC
	Udne/Z1Sjy93xoOGb9TKWXI7CeInbr0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-Mry9IIYTMqixbepQXmDzlg-1; Mon, 10 Aug 2026 03:57:29 -0400
X-MC-Unique: Mry9IIYTMqixbepQXmDzlg-1
X-Mimecast-MFC-AGG-ID: Mry9IIYTMqixbepQXmDzlg_1786348648
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47feac2021eso988766f8f.3
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 00:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786348648; x=1786953448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=faSl/UkvZhLeViesyQBAMKjmyR5NNeTyZ1tUwhC4yBU=;
        b=Y+QOYfQlxkT+6VEnP2akMUWJT5x7bPL1uhmFAZFmjOtSmKV7vfO38UceaNTgwEdqRn
         9nVsPKgGBavcawksjtpFs0inrP7YGG0wQfbxb3Ax+9GwR/n1QOJCpxVV7hBr8C8RfC/u
         XuGE6661Unrz1AeplXCu6Wmmrp8hj9DYI5ywiWVpOmjzcjMyTXtt+52HaFWncBlKD+AB
         pPLZhUJlgBY+TDDqrc+v3TW5ylIhZYeroVAJciq9FulM6Mhs6rZxDdIQarGogA0F+8NQ
         JVTi62li/GcUmWLNrCxTxVZXlHCEpj8WeLFW30l1L8D7aTc2o16ZOOEAJmfMKZCplShI
         pRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786348648; x=1786953448;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=faSl/UkvZhLeViesyQBAMKjmyR5NNeTyZ1tUwhC4yBU=;
        b=lFPIZVbDD6mMUrotZoB9UsRDsx9v6Kcavxi9un9nWYXyugq/Qwl6Odf7szk457Vfo5
         AJCQcl1Jb+7wzeAqeowzw+l+hE1dWow2AWp20Yg6XD2y3jLa/61kkRgaO/BcL+U5/OGl
         ZCc3B8EXTXOYIqp64x9E+F7X1zWZ6/CXhZugLxKPZP3lG+gEq/wVSMtRaI15a3QDaDPC
         EGa1LN5Eh8fIU7TPTVfQAVaQ0Iub70eq/GBOR8xDNze/57vvn11lj9d3gp0uLAmetZ9r
         YuRMBV7DyzXAU+/kV9nX2jTnBQY/AXogNYdICnGS7ZHBjPkd5la38Vh1ENtz8aO40A9j
         NIAA==
X-Gm-Message-State: AOJu0YyiEyPdbLpnLn7TZwZsscyWBo6qiiwVpZl9F9a5SJkhmFX27G+1
	ifJbKgdd7Uzb7MEIYIqfm6nAOpTE7JDe5KqRE+Uvo6IY0UOjgPrH5hVLZ79h5Ktvtp3TAjjdMF6
	zTiHpUp5yA54/kItOh7yrPS2bulg5nHMzretWM0zNi01JbvTOHrMkpymUuQ==
X-Gm-Gg: AR+sD119nVs/1a7vkwi8CUo/kRQ7DG3VHPDu1o2o28tk3L53CV0+oYMB5Xz/+JC9Dh+
	hbxbJkxVsJ+jaL1JUk4/pT4TjN4hTlD2DbyZB/OSPTpJ3k/+ghzf3Uzsk5L0kIzgNx2sD7eXIiH
	eTVI1k+XG99fMSE96Vz9kprHLzFoSHAoeM/0WlncrFL9sgE5HIF9inXktnUTRAF6Dyk+0yKo6X+
	yRC0AaHl/9tu1AABTpU5DiTTLMhpxRXHlMHf5BQAZGeZzSdo2N8wJ/gWvhIwqMUCJnq7idX19dK
	+IvltQBzQ4GNwXdHyiS7kUOFjfTd7QFiUth5jqnQJN/YH1H8jpbxC243yunUjue4F6bQAWS63FY
	=
X-Received: by 2002:a05:6000:2988:20b0:47f:eb80:ff42 with SMTP id ffacd0b85a97d-47fec4e2975mr52858451f8f.4.1786348647964;
        Mon, 10 Aug 2026 00:57:27 -0700 (PDT)
X-Received: by 2002:a05:6000:2988:20b0:47f:eb80:ff42 with SMTP id ffacd0b85a97d-47fec4e2975mr52858392f8f.4.1786348647534;
        Mon, 10 Aug 2026 00:57:27 -0700 (PDT)
Received: from localhost ([2a01:e11:1007:ea0:8374:5c74:dd98:a7b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021506c0sm29711749f8f.11.2026.08.10.00.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 00:57:26 -0700 (PDT)
Date: Mon, 10 Aug 2026 09:57:26 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, vega@nebusec.ai,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net] net/sched: act_api: fix TOCTOU NULL deref on
 a->goto_chain
Message-ID: <anmEZqiY_XEdzR_T@dcaratti.users.ipa.redhat.com>
References: <20260809090928.868186-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260809090928.868186-1-jhs@mojatatu.com>

On Sun, Aug 09, 2026 at 05:09:28AM -0400, Jamal Hadi Salim wrote:
> tcf_action_exec() handles TC_ACT_GOTO_CHAIN by first checking
> rcu_access_pointer(a->goto_chain) and then calling
> tcf_action_goto_chain_exec(), which does a second, independent
> rcu_dereference_bh(a->goto_chain) read and immediately dereferences
> chain->filter_chain. A concurrent tcf_action_set_ctrlact() (e.g. the gact
> replace path) can clear a->goto_chain between the two reads, so the second
> read returns NULL and tcf_action_goto_chain_exec() dereferences NULL.
> 
> Fix the race by doing a single rcu_dereference_bh() read of a->goto_chain
> in tcf_action_exec(), checking it once for NULL, and passing the resulting
> chain pointer into tcf_action_goto_chain_exec(). This turns the split
> check/use into a single check/use on one value.
> 
> Fixes: ee3bbfe806cd ("net/sched: let actions use RCU to access 'goto_chain'")
> Reported-by: vega@nebusec.ai
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

[...]

Reviewed-by: Davide Caratti <dcaratti@redhat.com>

Thanks!

-- 
davide

