Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D120D46C4D0
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 12:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790166936; cv=none; b=TxWQVC4qBOuBm/m0twcoiZ9eSpAqoKGNbBcN7TSuzR0UKVtDQLJkCKPJ1Tbgz2gm8qouYyIBK2Ig4Jvl1tS2b6/XHQWDSaDvszSRVK3zxAGL+NeG3YqL/jMqZu3yhQXWdvTaHC1toIUmktxV+M+aY0h/b5EFvNZmj6lfP2PeKgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790166936; c=relaxed/simple;
	bh=x7Apl9ihKaoaWZi5tsiyj9XdsN5NTj65ZbJChWnAXUw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rVRZcEIWzl+CbeZ4QVMT7QW00Djh5KOa2lSjKeBBHocQ7w3X12QceZ7vMBXtSE7f3Wrez+gG7eC3KAaebl1aK+z9wPjOGlXCtSJMP7KNdrXlTDDrdnpwzOS4hExB0VoaPPpUz/Dmw9l3oAL1S2reMxExoCqwQxoY44aiWaJwov0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HVR5VmIK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=a60OyogU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HVR5VmIK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="a60OyogU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790166932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UDQWN+qvZeX1gaIgZOYdsKlCuMncX8rgK5IP5SLXF5I=;
	b=HVR5VmIKsF2xO9VYs6f+e3tOSKYWVIKIDLNYaKPvboCJyWq27Z32ExTlpkUS1eW/GRUFqd
	IHAJ2TIFQLfzXfOMTr+5aUNHu7LBO8e1b54n2GrdY+GPmeL29o0xoa+Co6lRaDQu8JPzaD
	/Cjk4c3lge/YT6ll6g1sNECI29EfZW8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-_6M_xzzYMUKWmDhKTgPOhQ-1; Wed, 23 Sep 2026 08:35:31 -0400
X-MC-Unique: _6M_xzzYMUKWmDhKTgPOhQ-1
X-Mimecast-MFC-AGG-ID: _6M_xzzYMUKWmDhKTgPOhQ_1790166930
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49e6b5c5f44so12544075e9.2
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 05:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790166930; x=1790771730; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UDQWN+qvZeX1gaIgZOYdsKlCuMncX8rgK5IP5SLXF5I=;
        b=a60OyogUZ+HcW76z3sOpzu0sYxAgSCaskaeDeHAHgy3uDs6dg3MVYweUmRazLxr3rR
         ky25sj+3BYPckeFqZ9/ZZAv+9ODycMinEgwZb6RqHSNr2d50qhNyYAOmje8D4d5e6LrC
         XuU6GKQkOPeiN7oSjzbhmnI/IPU1710iM0z+X6+0pTw6gT5HIQonOsxQM8KXSG/8+354
         V6kpUuxqqeazPwnWB9C3OuRTFGCscX+sDk0vtTg6UdjNkgVN3ucskiq9xdNUDZHd162i
         hR19Gxv3BEd/vld7hxOsrMoW5mQlRZVo5whjeLwaclQf+DYVVCiy4YqU9fpKCczVboiL
         LhdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790166930; x=1790771730;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=UDQWN+qvZeX1gaIgZOYdsKlCuMncX8rgK5IP5SLXF5I=;
        b=1d2oaLvDTOfVLfKgT0QVIhNern2UjrxCaSMepcccTQwcjiIhevj6plhsvfYAs7Ayvk
         nJgc2swMHkHQlCPhbKuwvl27q5hPwQE3ByhTfLdfQobOsfGDl6579fPv2E7N0OXd9OnG
         kEUC+12iJ75jY5MXEgyNxLhA8fdkO3z3ZfSPg3kHZi6VI9bvgvfdPuAPWbAbEW918p9u
         On9chZSWqxEXHmyRkJteZBUm94pUT/psqiJqOv3K+JwLXtjEvFSiEd3U1kxtdlrMOyQk
         ePc0FG42dtzsaUN5NEXrHWu04KxAMxQfKxOSqcC3BrrcrfIFPHCqkCaIAmWq7IfSyqjE
         FnJg==
X-Gm-Message-State: AFuF++mgI77/hZfjkZ/8EMud9eDI2K5+dlznyMNhbzgkB3uUTx9QoPww
	hhI80hwfEPkuL/BZ9RFrYjrSSLG7v6IIHQB8Cy/DAs3GzsWBwEH+UBOxgulXdT8j+Xe5Z0zHrSv
	aZEbihOpShn78iS4fBJ4XzhB2lN3SMxA2V2oWZRgYlR9uwNWA53K39QEOYw==
X-Gm-Gg: AYBFou2iJki2mzlz2LQaaHYMmwswAV24Te7WNUujfwqeU0OEmiiIvQxH/73Ui/92IM6
	SMJxrXoNMsw3+c3XD5SA7hVlvO9Rm76g+GoBGNeQ3G4d71IOzwJ2FPq034V+WLHiD9pZaz5wmJT
	oEtBfgodaz698F+ag6J1GyU976viWb/Na1RcVXWcq1PsuPYFNgYaMWgTYufeLDwH5Ob0h/riWWZ
	90kl7k3zZNo11JpgrlVI4tPjYlesIPn2+CH2eWp1GHahMEictq2jL6KTGfKqICawfviZwW+PoQw
	7Tqjl8XCZaTUb+HoRCQlwRYRyPuK/4/wgRpZiWdI36gcQlXSNCSHkipFa/dYG/+nCMiUQn8BIO6
	7erq5urO0kCixwCnec1YAXrt7rJv8o/c1ZphzuLc=
X-Received: by 2002:a05:600d:1:b0:49f:e3d4:4c1f with SMTP id 5b1f17b1804b1-49fe3d44c52mr16737025e9.8.1790166930488;
        Wed, 23 Sep 2026 05:35:30 -0700 (PDT)
X-Received: by 2002:a05:600d:1:b0:49f:e3d4:4c1f with SMTP id 5b1f17b1804b1-49fe3d44c52mr16736585e9.8.1790166930125;
        Wed, 23 Sep 2026 05:35:30 -0700 (PDT)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([216.212.25.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde1ccb90sm75125185e9.6.2026.09.23.05.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 05:35:29 -0700 (PDT)
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
  dev@openvswitch.org,  stable@vger.kernel.org,  Axel Mierczuk
 <axel.mierczuk@1password.com>
Subject: Re: [PATCH net 6/6] net/sched: act_ct: fix helper UAF due to
 extensions realloc
In-Reply-To: <20260921145655.3167436-7-i.maximets@ovn.org> (Ilya Maximets's
	message of "Mon, 21 Sep 2026 16:55:48 +0200")
References: <20260921145655.3167436-1-i.maximets@ovn.org>
	<20260921145655.3167436-7-i.maximets@ovn.org>
Date: Wed, 23 Sep 2026 08:35:26 -0400
Message-ID: <f7ta4p89mcx.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ilya Maximets <i.maximets@ovn.org> writes:

> While calling the helpers, a raw pointer to the extensions area is
> wired into expectations list:
>
>   -> nf_ct_helper()
>    -> helper->help()
>     -> nf_ct_expect_related_report()
>      -> nf_ct_expect_insert()
>       -> hlist_add_head_rcu(&exp->lnode, &master_help->expectations)
>
> In case the connection is not confirmed yet, more extensions can be
> added afterwards with *_ext_add() calls reallocating the extension
> space and leaving the now invalid pointer in the expectations list
> that is later accessed while removing the expectation.
>
> Make sure that helpers are called at the end after all the other
> extensions are already added.
>
> Note that the helper rejection now leaves the mark and labels set,
> but that's not different from how the NAT was handled before or how
> the mark and the labels were handled on confirmation failure.  And
> there are no atomicity guarantees provided by the API anyway.
>
> Fixes: a21b06e73191 ("net: sched: add helper support in act_ct")
> Cc: stable@vger.kernel.org
> Reported-by: Axel Mierczuk <axel.mierczuk@1password.com>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>

