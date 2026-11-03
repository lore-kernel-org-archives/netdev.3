Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793707782;
	b=2uJK7SQtRi4Qa8ESxtGRhwDJef25Q5EuqLOm7sI/x3ZCRHGDYRMot/BmdGCul8m6doPb
	 hL486J6hyfqbXQSAyxWNdPhDkSjpIfGZrMmiA1uLXwzrIHTyYkeym2RUlVL7bQt+QpKHI
	 pJNnJtaWQzO4+9gSawArtQDikzew2g3Twp5z/FFJtg7i7AOhSqU7okYVQSvfNnvOlWhOm
	 jyVvB1agwmxWOdmHG5YqKZl2jD4F/N96b03TxVpduE+q1CAdholVyDBvoeXKd13a5+uGI
	 HEwggpSrIPB5dvrK0to/EFhVs2XjZzh0RmsFU6+V3ro6kXziJJR0AOH3EGB4LoDnyOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793707782;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=cjBl+xQjckO71yWChgagu6bNi+s2XZn6aD6ayTH9C6w=;
	b=39IwwV5ZI/oQDffHft1/DSmH9o6yFXyCLb7TTqn8MbivPs7ku1230K6MbqMsodpS3LEZ
	 gp0XXXchaHwPxC3B24/bDgCjQeY2ysxcFlGX61G72Gzqd1HNC6ek5YwczylkL9PtboEhy
	 8hiPbc4tBhSZWGozZzn1adbgWEPd5ZexxZ1cxA12zUAA/twISKEwSSqTlvCc6uBQ+pqOo
	 N9vL6SLdjd3sAiMhnXLooF1ZOerTgxrhaPdkGFWMXn6Khc7fJ2T4N1OyR8+e6PDdrqv7N
	 y6jb5JUP9nuUiMLtnpuZ1PgXzMvErqkG69eqB/m97HcXk1t+8Al5WMEzBVWNUmjF5rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GowN0pyC;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=a2XAfweR;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16166606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 12:09:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16166606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GowN0pyC;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=a2XAfweR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793707781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cjBl+xQjckO71yWChgagu6bNi+s2XZn6aD6ayTH9C6w=;
	b=GowN0pyCp0C5jeq0catblw6GZL1N9vtTj69JxCyGjCnDrhePW5bbalvQDf0bTpW1zwpFyv
	vq8CaPefQKn2Wi/6mhg9dN+AhI2U+GSbrWdtlhAMYLs6jPX/hW0iCBVCpMby5HMdU5R+cZ
	RGHw7fUROFFjZjKIbWrIcV2y5+wQKkk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-aoSRp6z3OJyE2r2esOlrlw-1; Tue, 03 Nov 2026 07:09:39 -0500
X-MC-Unique: aoSRp6z3OJyE2r2esOlrlw-1
X-Mimecast-MFC-AGG-ID: aoSRp6z3OJyE2r2esOlrlw_1793707779
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a0284121c6so40171285e9.3
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 04:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793707778; x=1794312578; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cjBl+xQjckO71yWChgagu6bNi+s2XZn6aD6ayTH9C6w=;
        b=a2XAfweR9Bcgjq32GvVvdgTVbwZ7BDPXtLbveiYOmpuYJYjlF5La+0jtH1GQt7ct2T
         mYTGRxOZ3hfBczGMygUjuNbFOKaGa9u7tsftemte8tRkfxbi2xr9v0Hxw58xdej5jwD3
         T00UCNEEQp33JZ50Q+1S4kRmHnHUx2MgflGpecKbKEHgxk1BsUCafEo7MNOdhdXx8h+I
         +nQci2SnwjTlwrMVDqbzoSawZ/iQ/Qrjy3FQ2h0edVrHWendaUZxNTQ4M2zOyM2sPnqz
         mNZvqgCV/MzqLu2s9EjaeD5cHhnQPXJDNhy4qBMOjPn3anC49/DTUvLzv3x227qF3p8g
         2xxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793707778; x=1794312578;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cjBl+xQjckO71yWChgagu6bNi+s2XZn6aD6ayTH9C6w=;
        b=aYSpcU90+zFcJEfbh5F95HN4YGJZA/2MJwG0I9QHYy87t5gZN7UM3KafnOFVN7BLIF
         PtogyITJ8YyrM1q+F4onDFcfSsqqW7Ihz3hgqIS32zObiKerk2nvYELVacPf5I4q8BKT
         qIikcSptWGx0R7B4O0fvjF/9QeMPt+JkrZsUuz4swcw2yBJDh6kuY/ysd/tcCdUy/KZC
         BrGbCFvRO8ht15d6qzs7oiXqmyud4mI54wpegx0HeOS9xTF/gRTOLlovxNDX9dAHX+IJ
         NWunNyOVwBMP3cr+c+0yJHESgVb7Nd9V8hRa+FI4zxy1a4ip4yycDUJrWWRLXIgY3U4r
         Dwjg==
X-Forwarded-Encrypted: i=1; AKwUvBzy0K5sr+tMYxkG35pyMr+PDXcLPuvI9exNHhuqOwo1YT9czdQUTHE5Y5HWIo6o645IKOrVNsI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/cPysIhu1vjoI+CPa8yNmYEab4QkWwxKSIluueZFQity6teq/D
	dqNmfNRyRczs8Fu5xqFJzs3uGtFmLmBkUkC0iEZQOjrKPdo2MoskjWWzYYmhqELRhBtO6/8/TIL
	bm+2IqI49clKaLqnCyjX4P1JGqaYZpKwkvnhoeEY0gXzWhoWA4qIcwaYxysIBYJB+Mw==
X-Gm-Gg: AYBFou388Bp+ACqorvC+vuMlGmeMAFYEYwFc841YCUJw81X4YzD1c0kTFxQyoZxcNro
	3rzJCm53PzTk1sfYR2g3oA0YcJMuZrZUmUgTfJOY+bsQuJJ59RvZQYWEy9y2wbZ+xPmNgQ9i1vR
	kF334jTynfNT8UMMvS7MA7MTOFSwEDJqtZYPsh/HVEuNB0DGZkYj4wZr2XEwcR6/g8F2m+YreKP
	VwvPghMn83y7+jwFkG2NKRM6JZnlz2jv2mxvVlutv6ZvyKUhk4BfvbA+uh1aCZOgEKAgXAtRiD/
	jqSNi6ItGLCx+wFXQM13/lmjWJDNZPSYi5lf992fLgdQVNP+zq26LNGXAy9KhUjpDYUL54NI7bc
	EahY6gRJID5GHfkQSmOjCsNxFsP811Cz2ztogLYFKZCsC0iwOhI8ekUqNBGYoaAROZgIUrIXUib
	QzXalfXjo/eut8Hf9eOLhXgPqTRMoUNcqgxpK7wipgvcw=
X-Received: by 2002:a05:600c:3d05:b0:4a1:faa1:3813 with SMTP id 5b1f17b1804b1-4ac187a6960mr293047395e9.27.1793707778512;
        Tue, 03 Nov 2026 04:09:38 -0800 (PST)
X-Received: by 2002:a05:600c:3d05:b0:4a1:faa1:3813 with SMTP id 5b1f17b1804b1-4ac187a6960mr293046905e9.27.1793707778109;
        Tue, 03 Nov 2026 04:09:38 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a5372d8bsm58867935e9.0.2026.11.03.04.09.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 04:09:37 -0800 (PST)
Message-ID: <997ed703-e1f8-4b6e-aede-b1a8a5ac6140@redhat.com>
Date: Tue, 3 Nov 2026 13:09:36 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] bluetooth 2026-11-02
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
References: <20261102222018.2610820-1-luiz.dentz@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261102222018.2610820-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/2/26 23:20, Luiz Augusto von Dentz wrote:
> The following changes since commit c3e67bd82b9b9b1a5118f09a429ccefe2aab0741:
> 
>    ipv6: reject wrapped temporary address preferred lifetimes (2026-11-02 22:31:32 +0100)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-11-02
> 
> for you to fetch changes up to 60b10121db602a43ada3dbc39792bbf93d25991b:
> 
>    Bluetooth: MGMT: Fix discovery stuck after a failed Stop Discovery (2026-11-02 17:09:03 -0500)
> 
> ----------------------------------------------------------------
> bluetooth pull request for net:
> 
> Core:
> 
>   - hci_core: Initialize IRK before publication
>   - hci_core: Initialize link key before publication
>   - hci_core: Initialize LTK before publication
>   - hci_core: Fix queuing rx_work while workqueue is drained
>   - hci_core: Keep link-key filtering inside RCU
>   - hci_core: Initialize advertising RPA work only once
>   - hci_sync: Fix invalid Supervision_Timeout in LE Set Default Rate
>   - hci_sync: re-enable legacy advertising on resume
>   - hci_sync: pause advertising for the scan address update
>   - hci_sync: Update the CIS host feature when enabling LE
>   - hci_sync: Copy the LE accept list under hdev->lock
>   - hci_sync: Protect resolving-list lookups
>   - hci_sync: Copy the resolving-list IRK under RCU
>   - hci_event: Clear explicit connect state on LE connection
>   - L2CAP: Hold incoming data until encryption key size is known
>   - L2CAP: Ignore connection responses with wrong ident
>   - SMP: Protect link keys during LTK derivation
>   - SMP: Protect LTK encryption with RCU
>   - MGMT: Return RFKILLED for Set Powered on a blocked controller
>   - MGMT: Clear disabled connection parameters when loading none
>   - MGMT: Fix discovery stuck after a failed Stop Discovery
>   - validate retained LE Create CIS command length
>   - validate retained LE Set CIG Parameters command length
> 
> Drivers:
> 
>   - btintel: fix buffer over-read in fw payload
>   - btmtk: drop zero-length ISO packets from endpoint padding
>   - btmtk: bound the ISO payload length by the controller's MTU
>   - btmtk: derive the firmware ISO setting from MTK_ISO_THRESHOLD
>   - btmtk: fix error handling in btmtk_usb_isointf_init()
>   - qca: Fix the WCN3950 NVM baud rate offset
> 
> ----------------------------------------------------------------
> Akhil Arul (1):
>        Bluetooth: hci_core: Fix queuing rx_work while workqueue is drained
> 
> Binbin Deng (3):
>        Bluetooth: hci_core: Initialize IRK before publication
>        Bluetooth: hci_core: Initialize link key before publication
>        Bluetooth: hci_core: Initialize LTK before publication
> 
> Catherine L (1):
>        Bluetooth: btintel: fix buffer over-read in fw payload
> 
> Cen Zhang (7):
>        Bluetooth: hci_sync: Copy the LE accept list under hdev->lock
>        Bluetooth: hci_sync: Protect resolving-list lookups
>        Bluetooth: hci_core: Keep link-key filtering inside RCU
>        Bluetooth: SMP: Protect link keys during LTK derivation
>        Bluetooth: SMP: Protect LTK encryption with RCU
>        Bluetooth: hci_sync: Copy the resolving-list IRK under RCU
>        Bluetooth: hci_core: Initialize advertising RPA work only once
> 
> Chris Lu (3):
>        Bluetooth: btmtk: drop zero-length ISO packets from endpoint padding
>        Bluetooth: btmtk: bound the ISO payload length by the controller's MTU
>        Bluetooth: btmtk: derive the firmware ISO setting from MTK_ISO_THRESHOLD
> 
> Ismail Tarim (1):
>        Bluetooth: btmtk: fix error handling in btmtk_usb_isointf_init()
> 
> Jinwang Li (1):
>        Bluetooth: L2CAP: Ignore connection responses with wrong ident
> 
> Kevin Dewald (3):
>        Bluetooth: hci_event: Clear explicit connect state on LE connection
>        Bluetooth: MGMT: Clear disabled connection parameters when loading none
>        Bluetooth: MGMT: Fix discovery stuck after a failed Stop Discovery
> 
> Luiz Augusto von Dentz (4):
>        Bluetooth: hci_sync: Fix invalid Supervision_Timeout in LE Set Default Rate
>        Bluetooth: hci_core: Convert hci_conn flags to a bitmap
>        Bluetooth: L2CAP: Hold incoming data until encryption key size is known
>        Bluetooth: hci_sync: Update the CIS host feature when enabling LE
> 
> Michael McAllister (1):
>        Bluetooth: qca: Fix the WCN3950 NVM baud rate offset
> 
> Tobias Wilken (1):
>        Bluetooth: MGMT: Return RFKILLED for Set Powered on a blocked controller
> 
> Valentin Kindschi (2):
>        Bluetooth: hci_sync: re-enable legacy advertising on resume
>        Bluetooth: hci_sync: pause advertising for the scan address update
> 
> Yifan Zhang (2):
>        Bluetooth: validate retained LE Create CIS command length
>        Bluetooth: validate retained LE Set CIG Parameters command length
Not intended to block this PR, but it feels quite large.
My understanding is that Linus is still actively pushing for smaller/
not ever increasing RC releases, and we should keep trying to redirect
to next non urgent fixes (i.e. the coccinelle ones fell like candidates
for postponing).

Please try to keep 'net' PR as slim as possible.

Also I guess you are already aware, but the `Assisted-by: LLM` tag is
now actively discouraged/should not be included anymore.

Thanks,

Paolo

