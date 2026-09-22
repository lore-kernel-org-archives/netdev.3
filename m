Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93178548570
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 15:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090876; cv=none; b=C20D51rVlAsj7QlVOQjYzxmCclxjRXnzpAWZD+EAbKvApMRr4vT2F/+3OBFyU0DGsPyvv6nj+29/U7XYGYnqK4iW6F0A3aHGXUJu32THarfTo5jWNporqENPbwsmeGYeUeO/h41Huf8ptmPCiIWa9tOLQFaL+lwk9xBzYpW+Q1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090876; c=relaxed/simple;
	bh=H6M2+2ePKHnNXtCxv8bZ8wAVt5XsjCTjUh+IXXp4Ros=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iv5fWscUAB4tpOTskeGd3BVG1cdsJcKBNG74yk+bwyA6eaU7O9ghLqaB4GCLM5jCsuKD5tMHMvk1kK3lsO1sq1T8V4bpQoAms8oVmlQYzxOZwwHqKB7MJThcUkirw4eKGcRy+vppCn8/BSI8St+c2gGAJszDrCtHsb1ODJikXL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EbKsA/z9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=q1ZVVWLH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EbKsA/z9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="q1ZVVWLH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790090874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SEowbgJIDHpYJATL6KIUYHLNQoCqqGPHET4KCWOduog=;
	b=EbKsA/z9eGmHarB+w4uXD8M4+85YbNAjj5bKNoB59oDPckb9L2Ck1ThlJAQMCezrYTgKWn
	tF1gYQwWJGvmtJ+cgwNcg0TwlpsGey7mQVW0Do7s8JnIcr3QU9n7fFZ5vQtd6BPdMOaZML
	vz97beOtkOXowGPdG8YzUyTYraO4M3A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-S726npSHPImKtfnHyOOJUg-1; Tue, 22 Sep 2026 11:27:53 -0400
X-MC-Unique: S726npSHPImKtfnHyOOJUg-1
X-Mimecast-MFC-AGG-ID: S726npSHPImKtfnHyOOJUg_1790090872
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49cf4cc2125so22805405e9.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 08:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790090872; x=1790695672; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SEowbgJIDHpYJATL6KIUYHLNQoCqqGPHET4KCWOduog=;
        b=q1ZVVWLHBMNKLX5Dgtn0l2hy+SfwNay+/vcl53sIsxL42H5I41/aFCw0Ys3VVYidms
         SNT9URUmdBI0xJqQjRxD3sBVU2g1KBR//8efVevHvLvJwIritEebmv/PMaEtGlRM7jaC
         3Vksk86Hg2+4o3bxfHMYc2cS7Zc38XeuFM1Auji1FMtSk9X1uf+ERGq0wuDFOHrihgoJ
         WnXCENGLe2XWRu6WTQN7vROSAC1l90nEeowztGywa3PHBlRjy386b46GQemPr2u6t0EZ
         Zr5UFK9lzm4LDTk5PNYleN/xjjv/TwCQiez/QwpoBPAke2oT659vipfDRlSgko/UZYsb
         EePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790090872; x=1790695672;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=SEowbgJIDHpYJATL6KIUYHLNQoCqqGPHET4KCWOduog=;
        b=0yKVosp6FsWoXKGxOeOHS+vim+h53ksj0oOzee9e46pvLsNT/JO3j5HdtMBgK0p8eY
         oYQU8bhMjgLKfAqez+mKypDafOrM2LDQa1cmqXOp+JOBEhbK6Fr1BQDg+z9aqNbfLSZE
         a3arNKLR4NJ5brGaRFW716METQ4CVrq+jBkTpmdphfCsOrktmpd+39tFkLITwLKvo6Yi
         gxkorAsHK2eI5d/Nsa59VYSjrWsl/yQ7JNNBdqChEqetwo5del49ov8hHOK6dY85cyWV
         auH5b0P/nHIhpP7Hla74N/1gqybpVcQrxaZa62bTfh3H8Kr9cQxHLLFHqRHySPjO6b50
         d5cA==
X-Gm-Message-State: AFuF++kuVXgY6PYGLQFjn6WFM6pu4XYx1ISVf5uEKR/myXu0n/AZlaC3
	TxAS0++EZ0SZwDBh4cm0168Bu43liSlMC86Ed5xvIMs6yQjQmXl5GnnXHvNPPjNcd6lplA5mQHF
	uPSledsHBNWm57/NYajIH9Ba3PFLKMT6P5nGgiXbnC6ceYrek3HPga4SeLg==
X-Gm-Gg: AYBFou2iwflcbg7I/pZM1MNwkc3T4/k/d9vT5apXF7Q1fzXNd5C3quad5LbzbquDVZL
	EFQ25R5rUjrXoC4/zqrZl8IbDRiDitwe4D3W9n51XemS1Hs05Jw67t2nH7hSqEPnY/g5soyVZSu
	nZxZFQp+9dXXGtuFVqiN04+n5NgATNosVFqF2V3fdRHLyIgCoDOqtav1K2zCkD6bjBn9RE3ZG57
	vsc5dltP23DrPrjenrB1QAKgGfpW8UEZZZDiLw7zrAbYt/NtnMRmfuturgDrX28BbRHfy/FXW/1
	DjGLwCVBVkpwqBrg8ki6PzpTryXE8IU24R16sapTNd4QsdOwB29/mcAY8K6P8CYiBQ9kRGbUnWr
	5b8kS1raOpNfcr//H6iEwiTXPCRUz
X-Received: by 2002:a05:600c:34c7:b0:49c:ff8d:b548 with SMTP id 5b1f17b1804b1-49fc5726cfcmr277170325e9.11.1790090872306;
        Tue, 22 Sep 2026 08:27:52 -0700 (PDT)
X-Received: by 2002:a05:600c:34c7:b0:49c:ff8d:b548 with SMTP id 5b1f17b1804b1-49fc5726cfcmr277166705e9.11.1790090867129;
        Tue, 22 Sep 2026 08:27:47 -0700 (PDT)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([216.212.25.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdab0e46fsm13166415e9.3.2026.09.22.08.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 08:27:46 -0700 (PDT)
From: Aaron Conole <aconole@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org,  Pablo Neira Ayuso <pablo@netfilter.org>,
  Florian Westphal <fw@strlen.de>,  Phil Sutter <phil@nwl.cc>,  "David S.
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Eelco Chaudron <echaudro@redhat.com>,  Jamal
 Hadi Salim <jhs@mojatatu.com>,  Jiri Pirko <jiri@resnulli.us>,  Xin Long
 <lucien.xin@gmail.com>,  Marcelo Ricardo Leitner
 <marcelo.leitner@gmail.com>,  netfilter-devel@vger.kernel.org,
  coreteam@netfilter.org,  linux-kernel@vger.kernel.org,
  dev@openvswitch.org,  stable@vger.kernel.org
Subject: Re: [PATCH net 5/6] net/sched: act_ct: remove 'add_helper' dead code
In-Reply-To: <20260921145655.3167436-6-i.maximets@ovn.org> (Ilya Maximets's
	message of "Mon, 21 Sep 2026 16:55:47 +0200")
References: <20260921145655.3167436-1-i.maximets@ovn.org>
	<20260921145655.3167436-6-i.maximets@ovn.org>
Date: Tue, 22 Sep 2026 11:27:43 -0400
Message-ID: <f7t8q4tb91s.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ilya Maximets <i.maximets@ovn.org> writes:

> This variable can only become 'true' when the connection is not
> confirmed, but it is only checked when it is confirmed.  So, it can be
> treated as being always false and just removed.
>
> Fixes: a21b06e73191 ("net: sched: add helper support in act_ct")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>

