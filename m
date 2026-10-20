Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792519606;
	b=PdEKa8M2pMTklBG8ytX2S3v0yVwrKXWad9LTfTW8Vqu3V/iaHBozlgVSJn1sNexX+0wH
	 ZweW7S5VpkV9aWd8K1gwQ0WpdTjtrLgHUvtRxTiq9NXhwtH65XGAFYTJHfqB4AS/Z2pgT
	 Immc8vzMuvBwEczGH65Ax1ueN3iekcv1RqxXBftOma0Mi5XPOIshw3qMf2RnZPdUhZmnW
	 bdpC2pXqCucLQGJnmSi5BTNUAyIcqbPKKJxiUM6aOITdeZ14IEXaGW0PV/pPWjth99eyd
	 kzF0+9ojmHrk6dyCp8u0OCj8GENm9vJ/buyE+XYFifesw6o/EB0DGA8Jw7OAGn2BSkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792519606;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=XzM7UKgxE0FtsrjcI8bgns6hPdNcwyb/UbRZ9e5cm/0=;
	b=X34yMq/HZZaFt9Fa07mCP1NwcWFOWMtOq+DjnOSJCeQGb5hmQtUQVJNK5NfeeUDE+dJB
	 uTml6fp82RIUdQCPDxM+TrMiKgx9j2S4SbuHGsm8SMGm2hbpFU/iwdsAWBTXdHnXrF1Vr
	 FFe7mDkRo0SxqtBgm3hif77b5LhFSdAQq3MuC1ooRzIdi/8HN1FsHZz0P4qwzvNSno6kX
	 Wq3qzk1xFi9zvoiCzIZH+Vi2UqLFoU3lGqMbUWvrWLY2hqM2K/asb5AAOYypvlK3h1vmQ
	 JFBKMJoiXa8i8aFEAHw1p8z86WyqHhMvCN6mePZmgo4OjHQFLTFM+/D4xAtXKT4GKXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=S4drKmBe;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E080606A31C
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 18:06:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E080606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=S4drKmBe
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cbedd5aece4so444045a12.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 11:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792519605; x=1793124405; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XzM7UKgxE0FtsrjcI8bgns6hPdNcwyb/UbRZ9e5cm/0=;
        b=S4drKmBe9BgJBjJv6mJVYRdQiWn4a2745yGJGjEeF5gbA7eAx++ZdpFZT5ReCUtvua
         OdzR370u7zRuw1QWYR8aT+2MOfl89mP8EBPNWk3L6nFQOZvpD6fGm8+bfLNmEYzINRRr
         pNY+JsZOjjzeit8aWF1xLoOoh6zn8C+1xjd6ogQL62/1FFR1OFxka/qVPhlbkrRaE7Sb
         E+iGGxlYrvd5yyUEJqOVM2S1vGzeu1V/90EwYtt2zJUo4UnlN0vpQaGaPTW1B/i5iJ4z
         IK9LzRFlh2E0rYje72lMqHID2oOLn67ZR6YZxnpG8oAXvWCYSEU9W6tlaquZBRwjhfTw
         oQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792519605; x=1793124405;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XzM7UKgxE0FtsrjcI8bgns6hPdNcwyb/UbRZ9e5cm/0=;
        b=nWZfM406wTxuZCe3BmAUk3VtMqecL0WNmZru56FhMdobdVJKW04TspnACGIpUEFuST
         DzyDrOjxLB0Z2In1D1qp+5LwnsCcQTi/b5u4c9mZCJxEUginsnlzPV4a5AzFgNQPbYce
         10QN9hB2/eZNVFMokdlvCBR3Tom1Ma4P0qQuP3KwFEhJJpjS92irZMcHafOA/trDhlpN
         A4BM5yB/nw/hw6Abpf1bsFLTTbUiVwGvKdrkv0zUz26/prGBDCFQ7xLMtppc9mqEVLJY
         mss0ygnnzDCWb9Gnolx1LAkrpCo1SF6wXbwnz1DgrBjszpfkzU3E8VtZsRm82r13RP8L
         bHgw==
X-Gm-Message-State: AFq9FYLllrlm+6S4aEsLmWBYVkoiuZqtGatrXRHHVfztIwCjt1AyKB2v
	Hyk/ABxC3i7YTYWp+azxBRiXUr7HWXxErkDgxtiDHrbf7NYVdP6NfdVaED8LtfEpcLY=
X-Gm-Gg: AYBFou3xM7x3yIEj7oTzVSVVYcRZparrXvk55KZUeFWWBTOYg+mqNCid8pV+zNUg5x6
	sbqJp9zpD7z0ZWfWDl/YvJvtaJxS/3sKBx+d+2OgTamd8sxikszKkFU4cYc6+8jLliCVw9X2T42
	irmrc+7nhVQFex3gTFRGEAEPguwGZqzA83zVQyY7VyVl4K8VxjPYY5IxefDU/2jDEtha59nW8wN
	cLYi9VnfF8qw9gLzELJxrT2JxRfSnyjTc7fmD1vFojES7tOIrxq+exaRLvRXmmUFkift0H7SA0B
	LxKgRVk8sM2s/Rk0d5HQz7poSDSUn2UanSIc26pTJVLmUWZqc4Ay06tyxDzIo4iHJ4Z/tU7wBj/
	5Pz2XpM6LpWxTv+IJOji543bLxGcq8potiQA3py5qNTS/PhPMDnnLdiCPMim6x0hE3dOBMOaq4m
	5UumDpJrDVj7U2+zCgeRb8kqDzCzfewMRt/LLg07OqUJ/Tk9j1gaVTIRGOKffOQiIw7CvjKl8dV
	kB53qLp4MJV4XvkBIw1X5tEqaywnZOueozX4RPXM+mQ51OfBFVLoEBKCsHSTDKf5CxflacTHvEm
	uEQldk/7AtbtkSF4iuamETN9A91JbyFyntfRCVLoap4=
X-Received: by 2002:a17:90a:ec88:b0:3a6:d850:bf16 with SMTP id 98e67ed59e1d1-3ad64bb7a75mr1660109a91.23.1792519604978;
        Tue, 20 Oct 2026 11:06:44 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad80912f26sm493560a91.1.2026.10.20.11.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 11:06:44 -0700 (PDT)
Date: Tue, 20 Oct 2026 11:06:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prashanth Swaminathan <prashanthsw@google.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, maze@google.com,
 yuyanghuang@google.com
Subject: Re: [PATCH iproute2] ss: bound fscanf width when reading comm in
 user_ent_hash_build_task
Message-ID: <20261020110642.218231ce@phoenix.local>
In-Reply-To: <CAHdA9BwQPp9ciwB4RxUd79AOkcFo6gb2t52NTtWq_52=K15p=Q@mail.gmail.com>
References: <CAHdA9BwQPp9ciwB4RxUd79AOkcFo6gb2t52NTtWq_52=K15p=Q@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Oct 2026 09:59:56 -0700
Prashanth Swaminathan <prashanthsw@google.com> wrote:

> user_ent_hash_build_task() reads the process comm name from
> /proc/<pid>/stat into a 16-byte stack buffer (char name[16]) using an
> unbounded fscanf("%*d (%[^)])", name).
> 
> Although the Linux kernel bounds the comm field to TASK_COMM_LEN - 1
> (15) bytes, bound the conversion specifier to %15[^)] so a malformed
> stat entry (e.g., via PROC_ROOT or non-standard procfs implementations)
> cannot overflow the stack buffer.
> 
> Signed-off-by: Prashanth Swaminathan <prashanthsw@google.com>
> ---

If you have a non-standard procfs, that is not our problem.
