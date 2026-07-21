Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0FE4779B3
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 10:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784628657; cv=none; b=d1t4mTEu9T5i7P+bBQ+Hx4jkL8Y+964/xE4RqG6HgMCTCs0wLcu3G44vG8wwY51F4HVFnqO/3E5FPGUMuT5hP1qGQRjlC6ak+F2K/P7AtOigMMsa8WoebOKWGjojctL9Gw8zIw/k20o9tlFe53OKmSw6b3F/Vz6Hw8j7aL6zUlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784628657; c=relaxed/simple;
	bh=udnHtGFPyz7hbUEOMNqTB0aEs+NZ+BXBJ7nkeUP+vq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oJfVcJRMiZXcGuV8K1PDSzY3O9GUo/MQfdzoL5RH+UAxt/dnfgZLyArewtn0gJCoriFiS4LYeUAGXPFPdTzCbL0LU8J8qzyVW+DaKLD7snV5v5iRZP+mQB1fVJGJcgsdJADArusYdkrssk9uu/5cWdKhpiEM7Ka3DiXnPb9ewgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BPIhmaxv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eAhDoOwB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BPIhmaxv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eAhDoOwB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784628649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JIme4w5kHzDPPwLxsVuz+NEgaFpd3AeI3j9Me/sme3c=;
	b=BPIhmaxvzL2I2dLpiYliZUi4Vl3ZZ4XlkVerlgwPOZPkJWi2Y1ISJd0cWs0YAnebMUBHLs
	AswKT4SnUMMdZgdYH/G1aRIo3lrEiBGsh/jpaKC4OAwGV8QtszB8pErhOTs5TBMLnzlSFF
	aIrhryRhmtKfKchb37pLzkWcxAxuFK0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-1rYrmpvlMbuJbPmgczkl1Q-1; Tue, 21 Jul 2026 06:10:48 -0400
X-MC-Unique: 1rYrmpvlMbuJbPmgczkl1Q-1
X-Mimecast-MFC-AGG-ID: 1rYrmpvlMbuJbPmgczkl1Q_1784628647
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49544a639e9so27994385e9.1
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 03:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784628647; x=1785233447; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JIme4w5kHzDPPwLxsVuz+NEgaFpd3AeI3j9Me/sme3c=;
        b=eAhDoOwBpbSC1emtGq975/cCLR7x86E2zo9S7vqWiYYwlBhKeW25dzYqQ1vDfrrisv
         Y1o75H6ZYZBHL8nP1N4kxti/xvOd/aXRY7/r0E/12c1EL9+ISag7NJN1psWLzwy2gV+L
         earKLORE7gWxf4Jz9s+wyskK7G7X3SI3XNVgMSUrOMd2hDlbXq8R0rdwCINrxUtl4DzQ
         tE5HapoIGMGPME+EdC0gAQOdjK5s+VldFh1aXwZxCFcB/YaAIhBm4bv3iOhphAzvY2pn
         vqVXXogsI1YrNZaT0Yz2Jds/Ye4AEdIcbwml8q1LMS8hjUhXC8kgROIhoU0Zv5dSHlzZ
         eGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784628647; x=1785233447;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JIme4w5kHzDPPwLxsVuz+NEgaFpd3AeI3j9Me/sme3c=;
        b=tB49k/Y5F3cmTohv+HdN9MjbSTI0H0KdLVBcv7h0h3O4XWi+SqQ3VKkDkDNY3ciUWv
         lNtUhxpyQftSI9IHpErMU119XZhSeqxMuTtAPnrHi3RcI0YomkekDyvYNvuDurxTKyOA
         EgMn4g/nIf8aTqM09RqWfRL7D2K09WLcDXq4dZoOSsKhviRA2aRiLVCet2k5UU5keH9u
         Qe6B/fnpt2cr1jeExh8NFJAd3EIv1tH81XcOeyyYFpEwB8dWP7VT30oUlH+ydiU1JGy2
         r+C7Mv+cEXK90WjKjPOHFRbBRMe056MgNmdH8Hwk8Ybaf81xOnnXt20SHl1DQugZmX38
         s9aQ==
X-Gm-Message-State: AOJu0Yx9+fCPSaj0wqNtgEFbqu2ZjNpUYZgRmg/oSt97w8LJwLzPalFb
	8It44B/JNH2ZQLF1zwJBMHZ1tCmpeq5F51+hAT+xJBuo4XxywsuxGkxghDVhmRG5duu4ihe9Orm
	mqHtxQsm31CP15dEMDFsOcYDJ61IsBGc1aZ/2LsM7nTBtl/my6j+U1eynTA==
X-Gm-Gg: AfdE7cmMUpc0R57gVpKm66GGviNWyEs4iJIRol3eXXZWW9Rw0rPJlY0R9bcqaBmu2h1
	JqGIxe3jaNmd8MNZGVPnVCzyL1xgrzrP6F4CdoGKB+R4bUcSmAC6SyAU/py0epff3EAHUhdTyP0
	lM9aQWR/6OsJDCSj4cFYI8zLU1EJTCHH52kWDk7M7LFn8GGhz01IbYl842alfOY7Niwo3EcC1H/
	j88LTZjrApfRdCC7f9ZQ5opktC8wyuyWd/iVjOuk26EUzOMkkM88K84JD2vp+Jn16JpBckbhBy7
	6s7nQY+pME+UaLb/eOaY1lr1LyEYeBu9SWq+nkE0WVcnpTCrcQBwXc9MoTWk+NWccqEI8pi8CS7
	a0Y6D+KA2HdpBorarkDl0RI+QNJyjWdbb90G9wfYXMFFK6O1/T6Jj728wKcCbHlV/hJj//AL+nu
	+ZFg==
X-Received: by 2002:a05:600c:b96:b0:495:4b00:1bab with SMTP id 5b1f17b1804b1-4954b001c39mr194096945e9.21.1784628646800;
        Tue, 21 Jul 2026 03:10:46 -0700 (PDT)
X-Received: by 2002:a05:600c:b96:b0:495:4b00:1bab with SMTP id 5b1f17b1804b1-4954b001c39mr194096515e9.21.1784628646245;
        Tue, 21 Jul 2026 03:10:46 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eea8afsm39599963f8f.33.2026.07.21.03.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 03:10:45 -0700 (PDT)
Message-ID: <68b5a2f9-53c7-4b28-ac8e-e61a39dde118@redhat.com>
Date: Tue, 21 Jul 2026 12:10:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] vsock/test: add test for small packets under
 pressure
To: Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowangio@gmail.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux.dev,
 Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>
References: <20260708102904.50732-1-sgarzare@redhat.com>
 <20260708102904.50732-3-sgarzare@redhat.com>
 <20260708065853-mutt-send-email-mst@kernel.org>
 <ak9h1kWcLmpP74PI@sgarzare-redhat>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <ak9h1kWcLmpP74PI@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/26 11:17 AM, Stefano Garzarella wrote:
> On Wed, Jul 08, 2026 at 06:59:41AM -0400, Michael S. Tsirkin wrote:
>> On Wed, Jul 08, 2026 at 12:29:04PM +0200, Stefano Garzarella wrote:
>>> From: Stefano Garzarella <sgarzare@redhat.com>
>>>
>>> Add a test that sends 2 MB of data using randomly sized small packets
>>> (129-512 bytes) over a SOCK_STREAM connection. Packets above
>>> GOOD_COPY_LEN (128) bypass the in-place coalescing in recv_enqueue(),
>>> forcing each one into its own skb.
>>>
>>> Without receive queue collapsing, the per-skb overhead eventually
>>> exceeds buf_alloc and the connection is reset. The test verifies
>>> that all data arrives and that content integrity is preserved.
>>>
>>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>
>> maybe cut down SO_VM_SOCKETS_BUFFER_SIZE? will make it easier to
>> trigger?
> 
> Currently, with the default value, the trigger is practically immediate 
> for packets between 129 and 512 bytes, but yes, a smaller buffer size 
> certainly makes this effect even more pronounced.
Given that PW is quite in a sorrow status, I think a (net-next)
follow-up is the better option here.

/P

