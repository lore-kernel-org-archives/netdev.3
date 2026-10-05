Received: from mail-qv2-f40.google.com (mail-qv2-f40.google.com [74.125.230.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632EA24EA90
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 11:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791198953; cv=none; b=YhRf6D8z1cLUW7Gm0i+1fKRfn8Se+RhGA1XACx0LSCT6wIycyE3q+n5AxaLYexCtTHj7smBOudItb0kJEkJJtHJAWB4yDBD10QrnpSpJMN7vBvb1gaF3MMSPEhSBvbLHARNjbQnj+nqkW5PcxKTWr5or+3PRV29nlap3Ok57ZDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791198953; c=relaxed/simple;
	bh=rC0HY6ly4WtATwY+ryB06S6qLofOlWhFLmRNhUICJq8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Gd+73WOT72lUejYcfidM7wAQ5AjaRmrMvTEusU07mVd/yYoaqPiDcX1l75a2nm328mVE4ZZnSZL69RwD+2UKA4hDNG/Xu1gs9wvu+cEAOTEofObbtVhU7bO3cL3JgskAHVhJ8RD5CU+g0eb59nNl6oUQ8CbXCnHC3tjR7MslMtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tF+soll9; arc=none smtp.client-ip=74.125.230.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tF+soll9"
Received: by mail-qv2-f40.google.com with SMTP id 6a1803df08f44-917ae0d5298so24475406d6.3
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 04:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791198951; x=1791803751; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rC0HY6ly4WtATwY+ryB06S6qLofOlWhFLmRNhUICJq8=;
        b=tF+soll9GsPA//XEJyU1z5bWAXrRFAZq+AHYtTcbqW5PvNjlRg4tyJbJqIiPQtnB4T
         /ofgox2obi4FeZBDLq3nqubIoLSyfTWRwldWyi0VacdwVL09isia5Z4iyUqZKZ20dDZK
         NvTNG1Ec+enzNQz4HLKUde23Nji9Xq3LesCq8As6nECwLNf6JW1E87C6wswLkqjIqcnS
         VWqG2cjOog/ZcT7vJGhM/NQuXtWnrwAw0i2v92qXtvWv3f9NTarzNX/EnezcCb3yeBTb
         +0pHO1waU876C0pUI1/0nDaooSD1bwqxqeqnBp9IUKJjJ0ajIWUkQbhJJ2wGcmUWxwXe
         iWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791198951; x=1791803751;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rC0HY6ly4WtATwY+ryB06S6qLofOlWhFLmRNhUICJq8=;
        b=Nc6j2+HEva+2e3emxHS4hoUxyvfWJldM9A5kFQelHwmgLhl5uM8YWZcdzhBwXMeUMe
         tQJ11XR5D7VTAVw+3OyY0EQE/iaM4YOs2jKjiEL0prfvXCNrPOgzu5sVgzEwQkDfRJKl
         9KQz4lA4M+6Zjae1dz+BsBaOWWdwYFXYqfE+6UPfRTKZZNvG6oC00lyTJSwzMZBfKvri
         cmJTPITUOAKEDN9ozX755MOQIOwgCd0UhPZLeY1IDLgquOPuAAgI1OYpZYol+yidRNAA
         ex/Uua1SQ4im/Bk5m3aAn/R+4BRgb+nBeBrQyLq8Cx7dg5pJx+pq/uhh3YoREVw83nzG
         VsZA==
X-Forwarded-Encrypted: i=1; AKwUvBxYq3j+tVjuM+cGsK0HyhBlMJNOQgz8CWA7cNMQ195qhYvGZjLF8RAmNVm+mWOCcNcQrIQ2rLA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ84D/P/BkBeQ5mwLBhLBBcg7/KpkFj3uTnF1bWZ4klRjHq+0Ht
	NRZvx0B1Sr+W7MSZLZHXApI9QDyZebU5xUX5DoX/7giqRcYiQgyBvjEd
X-Gm-Gg: AYBFou0u8gpD8NzfrN3VYgiwUQzu9zzLMDdoEUlXh2PfveJQFw5tepWGsPc2Bn2YyCo
	UbK62lypQJLl/Iu6wYD1ep5bRE71MgPFM6/M8oMbZJ0Ji0M/sEGNBIxWsUSd2Jwl/I12zjjVqWq
	S+A1aMRyhVvNcMysrGUR5K80YDklMg1H2F8LpoL9RnyPHV+ifT5Y/cvn4k7k+bIKYnto2DdEu16
	VqOD3sgpKzoEW+lU7IZzEi2OSn/5N4bmGLq5ilsj2f+gz7XLSsWl2MED4Z1W37im5gP/V0F9u7j
	SqP8SOd1RY6Z6t2UEgX5smYo4gl54FAVV5yGb8yEhn3wyBvLZXaitPCq47Lk3SqXst8yVW+jqYY
	qPe2BbmrAQ5RPBYqgv70sZ9YPFN51Y4PXIvXQr398oTXQAOO9LC8V4QOj4fzQq1nmO0nwhNpVHx
	jtcguih4kGBH4uSrUcKBtTfZK0i5zjqxtHP9QwJln1XzkYFdbJ5sT17EstfRTSr7mIP6ShvGUeL
	48NLN21SivnPQ==
X-Received: by 2002:a05:6214:29eb:b0:917:a1d1:3b91 with SMTP id 6a1803df08f44-917c00bd818mr213845066d6.21.1791198951222;
        Mon, 05 Oct 2026 04:15:51 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917e0bcc71esm84869686d6.33.2026.10.05.04.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 04:15:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 Oct 2026 07:15:49 -0400
Message-Id: <DLWV19JLLG9C.17IJGD2C6XDK4@gmail.com>
Cc: "Alexander Duyck" <alexanderduyck@fb.com>, "Jakub Kicinski"
 <kuba@kernel.org>, <kernel-team@meta.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 3/4] eth: mpnic: set Rx buffer minimums using
 page size and mtu
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Harshitha Ramamurthy" <hramamurthy@google.com>, "Daniel Zahka"
 <daniel.zahka@gmail.com>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261001-linux-mpnic-v1-0-6422ee74233a@gmail.com>
 <20261001-linux-mpnic-v1-3-6422ee74233a@gmail.com>
 <CAEAWyHfRqE5wJTi7jq6LAK4-+i0bTFGzVU_HByEGUJJ7sGcGbA@mail.gmail.com>
In-Reply-To: <CAEAWyHfRqE5wJTi7jq6LAK4-+i0bTFGzVU_HByEGUJJ7sGcGbA@mail.gmail.com>

On Fri Oct 2, 2026 at 8:50 PM EDT, Harshitha Ramamurthy wrote:
> On Thu, Oct 1, 2026 at 9:46=E2=80=AFAM Daniel Zahka <daniel.zahka@gmail.c=
om> wrote:
>>
>> Set buffer based drop thresholds in the Rx path based on page size and
>> the max MTU supported. The device will drop packets if it does not have
>> at least the minimum number of completely unused buffer descriptors
>> available.
>>
>> These thresholds are currently set to 17 BDs for both HPQ and PPQ. These
>
> nit: if there is a v2, it would be helpful for review if terms like
> PPQ/HPQ were expanded here.
>

Thanks for taking a look. The acronyms are:
HPQ: header page queue
PPQ: payload page queue
