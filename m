Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967B3370AE7
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 21:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791494573; cv=none; b=ZbI42q8b3CipBbahIfkSCMx8jT0mugR+dByfE7P2CURxqumnUhELsz5FoGdBLwdn9rc8M4hXLQvzeESxtIsIdgJey15W0lHVr8SFpnEdazQiQ27EWMN+JdZNOPgDwFUYov2OSG7aBvIbQazGuBEuxZ3gDJxKRabG0ICxYq55l+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791494573; c=relaxed/simple;
	bh=mHr9kL6c9c9jQ9Ezno5PwYLxEmO1oPHDA6nExjQ2TEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWr2AMNOJvlILYyhwkLiOqzOsTLz8a3neTlGY/xgiYYUERXNjzvt6bduChnye9ffz+rCRVTWyRahVrR2n5V56fBYSkjmCLEqe/QyCx6W7o55T83IQPRNQqh9m9fiMhjHrXRq00c1HXEaSXhiWwUFDdJedyow9d+qCiJVSV4Znnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PxtAUWBv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=b4CPNJL6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PxtAUWBv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="b4CPNJL6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791494571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TiSgCerODuxHYBFuZnaguDkUChHNNGy3RQpSlctnVCM=;
	b=PxtAUWBvqkBRcjIsjJa9U4IRhTf9xS3rf5g11XCDDJLOmEyv82yVCCDLYGMsYHm/Dm+nWx
	RGktAumtVUZwL+J/i4MtsYPofbO7+/rNhOsIl4NqnZIN7bEIVPZFWByC87IlpD+PS7mFFh
	y7yzd9C2JFteBO/SjLPrm8OkG5qcHH0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-9zgfsTLIORmIvRrnJOz3Cw-1; Thu, 08 Oct 2026 17:22:48 -0400
X-MC-Unique: 9zgfsTLIORmIvRrnJOz3Cw-1
X-Mimecast-MFC-AGG-ID: 9zgfsTLIORmIvRrnJOz3Cw_1791494567
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48c437ae7dbso927342f8f.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 14:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791494567; x=1792099367; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TiSgCerODuxHYBFuZnaguDkUChHNNGy3RQpSlctnVCM=;
        b=b4CPNJL6hR6TokI8RoN5RNhuKf+DBnY91ODYJOLCHYUs3fNysqgd2tE08Otx2MlvbU
         d9gnNpX4KUMgLP9kXW0KNtOu6dcs+InMoH6had+Hj3nnYAS++HDwQzBL/WyxuFrBKyfp
         yHFLUsng9xnIMdHHVKHP5Hcq3aAWpOJ5v+95Gw7g3SebUYIT5UQJpF9gqRi7kBCg8LPk
         ixklSPOfrM+kfqQXPi3nFCAoQI4E8vnNQQYyT3UcTQfdkZxj+LJCsy+4hB/PHmanLLgx
         PlAX0DmWTf9xVY+yAO9g6Imkwv+L2EwXRMG3TPZElftnGlMMMx64hSpaR+fobHgc+/7u
         tLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791494567; x=1792099367;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TiSgCerODuxHYBFuZnaguDkUChHNNGy3RQpSlctnVCM=;
        b=WrMPrqmtNiH0zbg+DAY147XeS00PBVNScX+0FF+OnjytxoWeeHZQceqiTFXzjyAAez
         DQq1bvXf9F4AtmTA9o8zFi4XTC19pq9mosnGXZqEGX+Ga9mSvxfzrVHfaRU9igyzbFeM
         +DnDE2ipDKoJX/ANqGTarY3HcVFBYwoOzJ9dLuw6bFqWobyhr757Uhcl736WEzGHxYTt
         v5I22SxwdFmg1b9HepznJxMhddn7XJDrNbTHbhpkbr5nHdHUhd1qGlFMjZWNxP4qw7a7
         UiWfcxdHYGXgfpbGb/TsfBZ+GQnfK3WGNFPKVReqADLYBijz2l6hZfAhkkB4/J16K5rV
         fJlg==
X-Forwarded-Encrypted: i=1; AKwUvBwGyBafiW0b9GESmXoYIQwPBgZK7SwTJmxRvv6WeU7wKqj8gDaj1j9rMRDHQKZ15QHUbBkeltQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIxA+NxU6Nzw+Y5lZDqSA0AUelIRb++EGG6ODf46OHWEQyHSpoc
	GQVzfJSxsH2Aqr437K9QkqqZwaPyAGY2zCYj+6bP9w4+oEpKIP1pVk4booS5iVzMDnQUXzCAs92
	DXEh/eE+x5jf/fGJ+4gECaQlJGLlxcZ5an5wLjGhclipUv/O7e6nBNTKmJw==
X-Gm-Gg: AYBFou38QppC3ZK5a8GLKNVVmgPE407ydkMCv3/my3OV4umjvePqtgtD7uXjkbeFYXv
	15J8i+/kGlXouIiF3GuWMJPINYbEhnT8Dw14oK8+r7F/IFuqDJUXTihQaZO7BVuAvxvZsgQQ0WX
	tRVJKErZib0DQnSFAUgPArVDNP8lDgm+A2nYvHc4OtODa5hAvtu5PpQwP0zSoPN3NZATZO/STgc
	45qFwBZN8uU5g4zAIzrXriVdC9ojlBbN+m9DBUoQk/PhvK39BuSEnLYvd50jio+RZIOLKo6wnOQ
	l6WTFN3RYmSKAjT6RpHuYtHjmqp3zxBhRYNLu4BI0tPDGRUj0PlipKcy6hFD+j1jYxNPKzw=
X-Received: by 2002:a05:6000:4683:b0:48c:4a62:9b31 with SMTP id ffacd0b85a97d-48db9c24c46mr196698f8f.5.1791494566880;
        Thu, 08 Oct 2026 14:22:46 -0700 (PDT)
X-Received: by 2002:a05:6000:4683:b0:48c:4a62:9b31 with SMTP id ffacd0b85a97d-48db9c24c46mr196666f8f.5.1791494566341;
        Thu, 08 Oct 2026 14:22:46 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dba1be42esm114482f8f.5.2026.10.08.14.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 14:22:45 -0700 (PDT)
Date: Thu, 8 Oct 2026 17:22:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
	jasowangio@gmail.com, willemb@google.com, habte.yibelo@gmail.com
Subject: Re: [PATCH net] net: extend virtio_net_hdr csum_start checks to
 VLAN, IPv6 and IP options
Message-ID: <20261008172119-mutt-send-email-mst@kernel.org>
References: <20261007163819.3041710-1-willemdebruijn.kernel@gmail.com>
 <179148831819.434549.14553358529954439471@kernel.org>
 <willemdebruijn.kernel.18efe47d2170f@gmail.com>
 <20261008165313-mutt-send-email-mst@kernel.org>
 <CAF=yD-+S83OzhObTKBKvqGayBCzCEeOpF5pO4b7=oFF-mxgwcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF=yD-+S83OzhObTKBKvqGayBCzCEeOpF5pO4b7=oFF-mxgwcg@mail.gmail.com>

On Thu, Oct 08, 2026 at 05:06:30PM -0400, Willem de Bruijn wrote:
> On Thu, Oct 8, 2026 at 4:55 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Oct 08, 2026 at 04:04:16PM -0400, Willem de Bruijn wrote:
> > > netdev-bot+sashiko@ wrote:
> > > > Thank you for your contribution! Sashiko AI review found 3 potential
> > > > issue(s) to consider.
> > > >
> > > > Critical: 0 · High: 2 · Medium: 1 · Low: 0 (1)
> > > >
> > > > If you believe none of the issues are legitimate, please reply to each
> > > > issue of Medium severity or higher and explain why the AI is wrong.
> > > > If any of them are legitimate and you plan to respin, please let patchwork
> > > > know by including "pw-bot: cr" as a separate line at the end of your reply
> > > > (one such reply per series is enough).
> > > >
> > > > - [High] The fix leaves the UDP-tunnel path, virtio_net_hdr_tnl_to_skb()
> > > >   in include/linux/virtio_net.h, with the same weakness it removes from…
> > > > - [High] virtio_net_hdr_thoff_valid() decides whether skb->data starts
> > > >   with an Ethernet header only from `skb->dev->type == ARPHRD_ETHER`…
> > > > - [Medium] On the non-ARPHRD_ETHER branch, virtio_net_hdr_thoff_valid()
> > > >   leaves proto = 0 and then guesses the L3 protocol from the version…
> > >
> > > All comments look valid and require a respin. Any revision will take
> > > them into account.
> > >
> > > Based also on the previous conversation in this thread, will review the
> > > approach. Updated in patchwork to changes requested.
> >
> >
> > But let's agree who works on this, please. Have a bunch of stuff on my
> > plate so if it is you, I'm very happy and will just criticise :)
> 
> Do you agree with my suggested revision that just drops the checksum
> offload request for weird packets?
> 
> Or do you want to investigate your suggestion to skb_checksum_help those here?
> 
> I can't estimate yet how easy/hard that will prove to be. Can
> prototype, but no guarantee that it's a fruitful approach.
> 
> The next few days I'll be OOO, so next week at the earliest.
> 
> We agree that this is not urgent, correct. So can do some prototyping.

Oh I have a prototype. Quite ugly atm.

-- 
MST

