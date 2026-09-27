Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EA63ABDA8
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 17:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790531276; cv=none; b=Hto9x8VyoYU/2Jm0S1VfKmEAu3sPRTSpIkzb9HJHFWjLIQwrGWksELT/8b9GTe3hLxiEHHECo0iraKtR/YygWqXSelvFMZygsWnYrwCQK0JihIRhF7cEyXxNg6QBqVuzlYIwTorCoBQSZGHcBmTXPFvbwKoMDlKP+ftaxz9JdL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790531276; c=relaxed/simple;
	bh=9O9x6jCYkM8Mjp0j0h/AxDubIJhEzV0Ag0nHkp3gETo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZtIRB8/4Tz14UguE0ES3azuRUfV1USEdudyofDJIxRNxPT0MCSBeU6pQoq92NCv6Xz2rQKj9zeJ63Q1wy+p4LvefJeH4bYB7pXsHbB6TEhLIsX6gMkHv2ozPGcvSmmZx6GCLPn6CI23zPEo3eTl0ht3gi8MRIaGVu/9PL4xhrWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUy7zd2D; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUy7zd2D"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-144f7915355so1944843c88.3
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 10:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790531274; x=1791136074; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hs2r4ykAL60oyHCuzzKHcgDsrrK0X6WcpAj7ycJdF/o=;
        b=AUy7zd2DfI5J+4EWVCZ0y84RU0XM6/F1jL6qs63lBKgGyxGoqLZB0Hlo7WM33PuwPG
         3FZ8Lk6ZO4YSPkEMa8jUo6xnKHxjLW7+NqdNRNpm2d/0qkEfZrpSisWuZfsI77CE9VPQ
         lZocZQZwy5JWE7RiPiEr8ORInB45ifOLGf5gXq1CCHuYmVcLxaZvdAh/Ol8f3AFCJfNw
         dS5WHpNbfyZf9iG+MNBAQzh9KhT3bVF9mp4kUdZNazvfg+DOj9tEpuhjEbGyq3b93ivd
         AgsgLKpBCm6zfOESDIv0f5WUyi4VZkhzeIBHrQmsewtnmg7NzhKK9XW9Dm/YnI4fAMRL
         YTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790531274; x=1791136074;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hs2r4ykAL60oyHCuzzKHcgDsrrK0X6WcpAj7ycJdF/o=;
        b=FOTRqPzIDSabHSi0zykSLDmSBEjqgKy5UZAnAX0bAzgN+T14VyusHXSF51c5cewEKp
         IqEad+vN1opYJvS1TDtNmWKU/sM4TlafGMmt454i+Ih2KVzeV5MQwM35H02AaH2TuvZT
         JxCsPd1/DIz09/PBUS61ixQjpAXnanWmSD1DvCETJYoggJZtcfxpIpjx5bPC2IAC1nMp
         v7f76/jqsa+Knx1EK834K4M7Bdqccr9ZA/6UKb5YtYQ6Y+FeED+VA2qlnUCEhK5ir+MS
         hA+XHMYX6gNorDKpc5grGGEpRy2jldfJWVaUsP24OjlQFFc6AMjGxWn6Lq5SDa4yppOc
         b/cQ==
X-Gm-Message-State: AFuF++n823jU3anHJqxzOtge/2DJdefJuu7Aq0bSAbuHFCZeFHk23a0Q
	+/Fg5L8tMim/vXza034JjCE5Zw30yJoNP/0qCxZEaQGrlVPEQSVinEo=
X-Gm-Gg: AYBFou1Msyj5ukfE4v9gS0dD7ngIlqaFs1/jyzK0UWNW47tNbwac0wIK7r7eegLIZBX
	fF1iaz+PAy4exjb9t3IyWJ3/Pl/Vj/puqznBdj5MYPE6my0Dcl9NndXLtVbq09NINjrTgTzmZ1e
	6R5gYiX4IWWz8vsfEYAAPcFG2lA72oVUelqiWeU8LXap8z9qJWmM4+z/gaOukXGzsOTiHwM4xBP
	U3VsgtrN5fQj/jEF5SThrfg7GmtObkCiBBJEOCE6veyFksZ9CEZ934tJvV7JsAejs1OhrzxDqgr
	bNb7go4M0KXjNHRA+FoCVJ48vPVUKYPsQCgMGaUh7vDW4OeqleVYd1wYLdWviQFN+AeSZgsH9Px
	t3QaPzpCmOWG4v6H+D3YIngrBQKVcOkkaLKh4HGbsgzV/gJPTHT9DHSEApZel7GRogfWPMBCdOr
	IiPrkRAIY3qc+vjIT51WDK4HtDAzagHKp6OCPSNXBgIfe1M4KRz3FEYKjclXymcBGUNUrBnZnzO
	d8VfEXGZSOzNpYlhj/Myyw2e4gs5/VDvga65IvjvCt2AM8=
X-Received: by 2002:a05:701b:428b:20b0:148:80d4:84ac with SMTP id a92af1059eb24-14880d485e6mr3185429c88.29.1790531273115;
        Sun, 27 Sep 2026 10:47:53 -0700 (PDT)
Received: from matheus-note.localnet ([2804:7f0:84b3:2201:fb27:8354:17d:2bcc])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-146bb6551d9sm12611081c88.9.2026.09.27.10.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 10:47:52 -0700 (PDT)
From: Matheus Sampaio Queiroga <srherobrine20@gmail.com>
To: Gaoyang Wei <yhyxwgy@gmail.com>
Cc: netdev@vger.kernel.org, pbs05 <xuziyougm@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King <linux@armlinux.org.uk>
Subject: Re: [RFC] net: towards a generic PON framework
Date: Sun, 27 Sep 2026 14:47:48 -0300
Message-ID: <rKgB0LBiQcWdd3f5aVEwfw@gmail.com>
In-Reply-To: <f3f5b31e-e434-452b-a77d-72ea740a5753@gmail.com>
References:
 <20260926174601.1675-1-yhyxwgy@gmail.com> <tyVeMFhOR4aOm-Y3BnbglQ@gmail.com>
 <f3f5b31e-e434-452b-a77d-72ea740a5753@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

>  > I exposed it by poling in ioctl in the dirtiest way possible, by
>  > generic netlink and for sysfs.
> 
> This sounds different from the packet-oriented net_device design I was
> asking about.
> 
> My earlier question was specifically about the OMCI interface which
> users were able to attach to a bridge: was that interface registered
> as ARPHRD_ETHER?
> 
> If so, I think the bridge problem is probably orthogonal to whether
> OMCI is represented by a net_device.  An ARPHRD_NONE OMCI device with
> no Ethernet header should not be bridgeable in the first place.

sdk userspace use normal netdev with this flags: NETIF_F_NO_CSUM (for old qmda versions en751221, en7528), IFF_NOARP, IFF_BROADCAST and clear IFF_MULTICAST

>  > with a similar port of the Airoha SDK I had CPU usage of around
>  > 2~15% ...
>  >
>  > With OMCI in the kernel, the CPU overhead dropped to around
>  > 0.8~2.0% ...
> 
> Could you describe how these numbers were measured?
> 
> In particular, it would be useful to know:
> 
>    - which SoC and CPU frequency were used;
>    - whether the userspace version used polling, Generic Netlink, or a
>      packet socket in the measured configuration;
>    - what the MIB size / message rate was;
>    - whether the memory numbers are process RSS, total system memory,
>      or kernel allocations;
>    - whether both implementations used the same MIB representation.
> 
> I ask because a polling ioctl/sysfs implementation would have very
> different overhead from an AF_PACKET-based OMCI transport, so I do not
> think we can yet attribute the measured difference to the
> kernel/userspace boundary itself.
> 
> The Realtek case you described is also useful.  If the OMCI payload is
> the same and only the data source and hardware delivery path differ,
> that sounds like a good candidate for a small transport/backend
> abstraction rather than putting those vendor differences into the
> generic OMCI model.
> 
> On the optical side, your explanation also helps.  Keeping telemetry
> in hwmon, calibration in NVMEM, and leaving wavelength/frequency
> selection to the PHY where the PHY already owns it sounds like a
> reasonable boundary to me.

all tests were monitoring the IRQs and threads through top and htop on SoCs of the en7523 family (en7529ct and en7529dt) with a frequency of 1Ghz and 1.2Ghz on 2CPU cores, with 256Mb and 512Mb of ram, in total 3 tests were carried out for both implementations,
with 350, 600 and 800 MIB objects in both userspace and kernel space.

The tests monitored the total use of the system with only the xPON subsystem and the basic one for a DHCP and wireless server for 15 minutes

polling tests crashed the system several times and were not fully tested

the entire system before the xpon subsystem was started was using between 60mb~80mb of ram with both userspace and kernel space


