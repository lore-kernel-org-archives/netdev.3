Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADE137E5FD
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 19:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784575829; cv=none; b=KGGaWHg2GjuWqH0ILz5uwMA5fwJwx7/uzGhcHYiJi7nq44FL/P8BTZFj+1w04exHqG8jkPAZQ/7r1p8aPn9DUnh1eWyUe6sInZU3qW3EWjkyb2A73yVsIq9enqhL7TWZmsQ6HNX50SSVUHJMMtt2lcJjmIYLRVIYjPzixwK9xy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784575829; c=relaxed/simple;
	bh=p7VQ2Pd3Fiw/H+WB3lcNB7PgSTuyd8VktoYa+SbgJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEQ7JOI8Ih0kjW2nAk8pWPQoUwZMZ7TOEWctHmqv+JA42DmkaB/Y/Ad15kml2loGJzbSNRl7U4CyWL8vsfCxTb5Jriw6KgYDvlK44sSA/O4lCQIe3MMI3XPrts4k5ZOaAg7q2rnbPEf/j7Doay0th9ckF8cGwTFn+42JFiUJ9Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gqh69Fhv; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gqh69Fhv"
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2cb3f5bb19aso24043085ad.1
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 12:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784575828; x=1785180628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yGJF9pLUXlqnJd07Xxy4HVI4BDOBEi2qfOvqFhaqHzk=;
        b=Gqh69Fhv5byahLfZI2mhXQtwOKGQ1jCH7oCWfJrtU9N0pChbEjgl1hP+00aITnjYi/
         yA5HkZk/FS7TR+sYaC49SaNxyM2HjVScTiqIN27YlkL6jj3hu4g7NL7mFA0dVUpla1yn
         rGiq4YRGGd6238sbUTErDVBXSv5wsT5x2St/ehnZVu8G2LyCrkomUb82J58sOXOq0Vnx
         fJNsAgvbU9d9iISygouSsUaiHw1YkJEnG1G7amQCSdiifxuVsbO99rZZH8UlVEGhLWKN
         ZP6Pg0rh5ohnS1tn+EFIW2hA/FjBPPGLC2f15vdoDRrPazhA1/AE5CzMPWH9Cw1o5JBl
         p7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784575828; x=1785180628;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yGJF9pLUXlqnJd07Xxy4HVI4BDOBEi2qfOvqFhaqHzk=;
        b=cF+ZPfTAQXnkopLRt9aP0XjcbKRpnEntkiAIPojdJ3ztEdBD6thy7+xim1SHXj/b9u
         OW83YmNSuD9tRsHtvUcQO6S2Vg7b0/7p2a4OFlz13xYTMS+9lk/eyibDivfqoof2eHZJ
         vs4jpIwsf3YnNlfRwpYL7P3S3t0OSwHNd2bTOQzO/z6R/mugdEBJSh7B1SITgAT+Gz/Y
         Z9QvV+1KpfhKj8wpddKiWatzVi01gMV8oVWeGVZaI6ZzHAeD/eNu7vcghY8uNpxlsnvh
         k5VKFlB1HLjCsMoqffxjzzVtlm10Ee9VyvDZgubiZPffU7gn3t/CDBJyM89XoQZ6bxlj
         l51Q==
X-Gm-Message-State: AOJu0YyNutRi8HZ1mFe1N4frwIIW8Gg7TXK2F/E9ZMcGVnkkflFhXAA7
	Og1Y9uMVMuiggC6nhDyLnc8EgPThChni5QnB2twu+vrb9RyvN4zJ8i0a
X-Gm-Gg: AR+sD10pKF7Q0AL1yZ/paOgiutisNcsC/k0xLaVCjlabcNd2b9FXspNq49m1a3JlJFN
	hsBDdbqT4KIBhxZzrDO4N6GoKTkwbvWaZpiRyawwQM2YrbG45zLGsdeY6S6Nb6WLVq66ykmSlW1
	1uo8D72HBOpDhLPG+TznPIUuVRjDsAwEdfgn9/gy7TLs982eGylMG+NGGuhOEBz3KGuuA2b/77b
	r7cE1kG9nrnUFlo95uypwucoTJtbfc8BeKZgANKx6Ui1btqT1+zOiIXS/GVzt8IOAr86dCL2feo
	I7rEcboeBCGvNim65Ub7DMxpEj6T0V/i/wSUovipX+jBDqd2IOtiMxsvFuGOgixUV1X6d6//5ta
	tRfDDi94BJMhqOjyH5av/EAGHZKDa3M0QJrlrnA1jm8IY5hsFEcrMSUNpQuctQ8ptGitRvds=
X-Received: by 2002:a17:902:c401:b0:2c8:f34c:82c0 with SMTP id d9443c01a7336-2cf3484726dmr163356675ad.2.1784575827898;
        Mon, 20 Jul 2026 12:30:27 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:53::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344b36f9sm64612355ad.23.2026.07.20.12.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:30:27 -0700 (PDT)
Date: Mon, 20 Jul 2026 12:30:22 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	bjorn@kernel.org, kerneljasonxing@gmail.com
Subject: Re: [PATCH v4 net 0/6] xsk: fix AF_XDP multi-buffer Tx descriptor
 reclaim
Message-ID: <al53I9K0ThMPXjSU@devvm7509.cco0.facebook.com>
References: <20260719135609.147823-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260719135609.147823-1-maciej.fijalkowski@intel.com>

On 07/19, Maciej Fijalkowski wrote:
> v3:
> https://lore.kernel.org/netdev/20260714140722.111645-1-maciej.fijalkowski@intel.com/T/
> v3->v4:
> 
> * Return standalone invalid Tx descriptors through the completion ring in
>   both the generic and zero-copy Tx paths. Advancing the Tx-ring consumer
>   releases only the ring slot; returning the descriptor address through
>   the CQ also transfers ownership of the corresponding UMEM frame back to
>   userspace.
> 
> * Remove xsk_tx_batch::consumed_descs. With standalone invalid descriptors
>   now reclaimed through the CQ, every descriptor permanently removed from
>   the Tx ring is represented by either tx_descs or reclaim_descs. Use
>   their sum for Tx-consumer advancement, shared-UMEM fairness accounting,
>   and progress detection.
> 
> * Ensure that generic reclaim-only processing publishes the updated
>   Tx-ring consumer even when no packet was submitted to the networking
>   stack.
> 
> * Update the XSK selftests to count every descriptor submitted to the Tx
>   ring as an expected CQ entry, while continuing to count only valid
>   packets as expected Rx traffic. This covers standalone invalid
>   descriptors, invalid multi-buffer packets, oversized packets, and the
>   non-verbatim STAT_TX_INVALID tests.
> 
> * Update the AF_XDP documentation to describe the completion ring as an
>   ownership-transfer mechanism and document that standalone, invalid
>   multi-buffer, and oversized Tx packets are reclaimed through the CQ.
> 
> * Add Jason's tags

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Kudos for updating the doc with the new expectations! (and I still hope
that we can separately redo the generic tx path)
