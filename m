Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515AE31813A;
	Fri, 14 Aug 2026 17:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786728994; cv=none; b=u4bJnli8BggeQN3KvCjUbMPIPZyo6PlNm5Mgv1pxlKbMcnKle+B3pUsHL/xdrsN98t5cwc8kkD9t7XdXuDYkc4DhbRMONhD7ge3DxMT7qArml9xghMkTbP9vvurTQRXYp3CRGrKzG0mUdTAHndakDAvr7hZQYn6/LKxTvgIeZ2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786728994; c=relaxed/simple;
	bh=aU76XfWZ2B+xn8IINbF4JMOjzQ0EYKoYBBnnLBIgVFY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ugAf8YjvzIgY4e9lrGcfWyWt64Oz07DgwpUoonmP7tDkovdsmC6RNTNrTp0ZcJO+IR5MBb9Jv52jR6z5kAFFNJxqH+ygU7vRtsoiY9aAJkoFcpWurYx0oylhIFFAwjF8LY5BTnfrdm5x4oTgAcDpKWpVNrV/f7oouP4gVLXBWB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMQvC10H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMQvC10H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C1C1F000E9;
	Fri, 14 Aug 2026 17:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786728993;
	bh=mf/Oh0CJVBa+xZqD6qZtecCPEbP/GK8ZbDOjo/ee+Tw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dMQvC10HO/12daVYPH1Tp+Kri4AR+S9nXRhciTzc4EdixwE72DYh6juUzOKfWBKzK
	 QkMX1QUgw8DiXS3rIuXJR6gi8qKIjvAzIJZoowZ8oJ6xmu3tNaCoKim6gabKPT0Il9
	 7ml/9Y5BbY/S377lEUSgPwXeV9gcZFXZjy+ykYtDkFrIiIcWdXFR/ksrLDh2323RAV
	 I6OdoaFBdUCLi5RVxrqC/qm0AJDgzo986k01ZPG3599KTKF3kSmhHnr04B2+h8v4Rn
	 JxFRcsJnQRlaekHetckegNVx8tdQC43hbYQ+UPjtXbldR5Exs59TbwZv+z6632jQx5
	 hkO8vzUUAB/AA==
Date: Fri, 14 Aug 2026 10:36:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>, Parthiban
 Veerasooran <parthiban.veerasooran@microchip.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v6 1/4] net: ethernet: oa_tc6: Protect skb pointer
 used by two different kernel instances
Message-ID: <20260814103632.4d620d22@kernel.org>
In-Reply-To: <DM5PR02MB33697DFABDC38A6C5C0946CD83DA2@DM5PR02MB3369.namprd02.prod.outlook.com>
References: <20260812-fix-race-condition-and-crash-v6-0-6cf90f4a271a@onsemi.com>
	<20260812-fix-race-condition-and-crash-v6-1-6cf90f4a271a@onsemi.com>
	<DM5PR02MB3369B6A836C24C3DCE913F5683DB2@DM5PR02MB3369.namprd02.prod.outlook.com>
	<190d172c-ee3c-4396-baef-1f0765f72ec8@lunn.ch>
	<DM5PR02MB3369B34BD9F03C712032939383DB2@DM5PR02MB3369.namprd02.prod.outlook.com>
	<DM5PR02MB33697DFABDC38A6C5C0946CD83DA2@DM5PR02MB3369.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Aug 2026 05:20:48 +0000 Selvamani Rajagopal wrote:
> > > I think this is giving a warning that when net is merged to net-next,
> > > which happens most Thursdays, there is going to be a conflict. How bad
> > > is that conflict? If it is trivial, don't worry, it will get
> > > handled. If the conflict resolution is not obvious, maybe you can look  
> 
> 
> After little investigation, looks like it is trivial issue and mainly it can't be handled by 
> rearranging/changing the patches. Issue is the context differs between "net" and "net-next" branch. 
> I am hoping that this can be resolved while merging.
> 
> In the following example, "net" branch has INT_MASK0_ALL_INTERRUPTS. But it is changed to
> OA_TC6_INT_MASK0_ALL_INTERRUPTS in net-next branch. So, no matter how I move the code around,
> this will not apply cleanly.

Ignore that warning and wait for a human review.

The patchwork warnings are _for maintainers_.

As Andrew explained the best way to avoid this is to upstream fixes
first, but if the conflicting stuff is already in net-next we will 
deal with the conflict.
