Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B477082D;
	Sun, 30 Aug 2026 08:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788077447; cv=none; b=GMTKNDjdQYCTz0ZPo8lpgiITnHN0XxZNvL+yBRjAHSbynY8AJaAshv8CWXD1UwGJC79cUpoL1l0w0BXmIRKcrZ1+9lpnQdrdiA+iA/dRYLA/EIeeoCQRx9sGOZHr17ivz0uP26vXQTk/VIUDjbfFL3PQ+rAZ/1OwySUPXeRQorM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788077447; c=relaxed/simple;
	bh=Kugud/CgGGMJXt8tPet7f59Mo21uBHH22x8PS9SKOO8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Woh0jykFvPJla43Sdn+wrYZUUPpCe2JdanthHaYjHmcEv7DtNYtfrcomeOTAD4mo+8Gmgy9ypMjdwmNyuUJQFGOCP+0vzWKq4zwZbTWKVVKbUmb5Mv/l0H1a1Aeu56hm2cWPHAJ9HnJ0DLeR21/gnqcXVeiY3XL+vHAYKZBKgeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+CnEfqt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+CnEfqt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4D51F000E9;
	Sun, 30 Aug 2026 08:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788077446;
	bh=roA3pn9tytWMEXCOgBxbLuMlI73dGfxw422usJPW7ws=;
	h=From:Subject:Date:To:Cc;
	b=g+CnEfqtLN6YUoq+dT274N/zsTIZktli69oN0lC8EXm6TfKebORKrOjPyJ5V4Hc1/
	 7ZJRxEfuZwTEBu8hxRmGCytaJh7VHkbyVkTRhm8wbUxHObSYkTvyz5jyH9LaBs+hDb
	 IQHVTJO1tqpCZY2nfl5rug+O+lNQzgt+NmKtUbxmTN7KtIzvKocteZOpga8xLeN9O0
	 dbATn+SstNgbhJi3do34ibCrnWKCajk1PwKSqhAXeZLFGGJ28250c+zUNC7YUXn+bc
	 8O/dYy95oiKmlzSTKtwDFRdUKO8NlAdZphtdTa9D8UWr4jwZ3IdJhCs5+f/JSUOVrH
	 uRSbGkLeJTJ0A==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH 0/4] USB: replace page allocator calls with kmalloc()
Date: Sun, 30 Aug 2026 11:10:36 +0300
Message-Id: <20260830-usb-v1-0-aa349c302246@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMzQ7CIBAE4Fdp9iwGMP6+SuNhgUXWAxq2mCZN3
 71Qj99kZhYQKkwCj2GBQj8W/uQGcxjAJ8wvUhyawWp70Td7V1WcwqDPltDEiAFa81so8ry/jM+
 /pbo3+alPe8OhkHIFs0892nk9nmBdN1ZD0b6CAAAA
X-Change-ID: 20260829-usb-ad052ea1ffad
To: Chas Williams <3chas3@gmail.com>, Duncan Sands <duncan.sands@free.fr>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Johan Hovold <johan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
 Mike Rapoport <rppt@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
 accessrunner-general@lists.sourceforge.net, 
 linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org
X-Mailer: b4 0.17-dev

This is a (small) part of larger work of replacing page allocator calls
with kmalloc.

My initial intention a few month ago was to remove ugly casts [1], but then
willy pointed out that Linus objected to something like this [2] and it
looks like more than a decade old technical debt.

Largely, anything that doesn't need struct page (or a memdesc in the
future) should just use kmalloc() or kvmalloc() to allocate memory.
kmalloc() guarantees alignment, physical contiguity and working
virt_to_phys() and beside nicer API that returns void * on alloc and
doesn't require to know the allocation size on free, kmalloc() provides
better debugging capabilities than page allocator.

Another thing is that touching these allocation sites gives the reviewers
opportunity to see if a PAGE_SIZE buffer is actually needed or maybe
another size is appropriate.

For larger allocations that don't need physically contiguous memory
kvmalloc() can be a better option that __get_free_pages() because under
memory pressure it's is easier to allocate several order-0 pages than a
physically contiguous chunk with the same number of pages.

And last, but not least, removing needless calls to page allocator should
help with memdesc (aka project folio) conversion. There will be way less
places to audit to see if the user was actually using struct page.

The patches are deliberately kept small: each one deals with a single
driver or subsystem and with a single type of allocation, so that every
conversion can be reviewed, and if needed reverted, on its own.

[1] https://lore.kernel.org/all/20251018093002.3660549-1-rppt@kernel.org/
[2] https://lore.kernel.org/all/CA+55aFwp4iy4rtX2gE2WjBGFL=NxMVnoFeHqYa2j1dYOMMGqxg@mail.gmail.com/

Note that the buffers in usb/core/buffer.c and usb/mon/mon_bin.c are left

alone: they are mapped to userspace and thus really need struct page.

---
Mike Rapoport (Microsoft) (4):
      USB: usbfs: replace __get_free_page() with kmalloc()
      USB: cxacru: replace __get_free_page() with kmalloc()
      USB: speedtch: replace __get_free_page() with kmalloc()
      USB: serial: wwan: replace __get_free_page() with kmalloc()

 drivers/usb/atm/cxacru.c      | 16 ++++++++--------
 drivers/usb/atm/speedtch.c    |  4 ++--
 drivers/usb/core/devio.c      |  4 ++--
 drivers/usb/serial/usb_wwan.c |  6 +++---
 4 files changed, 15 insertions(+), 15 deletions(-)
---
base-commit: 1b78070aaef63512688aebfbc82365ef9d6660f1
change-id: 20260829-usb-ad052ea1ffad

--
Sincerely yours,
Mike.

